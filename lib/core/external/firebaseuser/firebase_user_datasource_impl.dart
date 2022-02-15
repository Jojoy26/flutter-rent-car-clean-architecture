import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rent/commons/infosUser/infos_user.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/infra/datasources/user_datasource.dart';
import 'package:google_sign_in/google_sign_in.dart';


class FirebaseUserDatasourceImpl implements UserDatasource {
  

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  

  @override
  Future<LoggedUser> singUpByEmail(CredentialParamsSingUp params) async{

    try {
      UserCredential user = await auth.createUserWithEmailAndPassword(
        email: params.email, 
        password: params.password
      );
      if(user.user?.uid != null && user.user?.email != null){
        var response = await users.doc(user.user?.uid).set({
          "name": params.name,
          "phoneNumber": params.phoneNumber
        });
        return LoggedUser(
          email: params.email,
          name: params.name,
          uid: user.user!.uid,
          phoneNumber: params.phoneNumber
        );
      }
    } on FirebaseAuthException catch(e){
      if(e.code == "email-already-in-use"){
        throw EmailAlreadyUse();
      } else if(e.code == "weak-password"){
        throw WeakPassword();
      } else if(e.code == "invalid-email"){
        throw InvalidEmail();
      } else  {
        throw Exception();
      }
    } catch (e){
      throw Exception();
    }
    throw Exception();
  }

  @override
  Future<LoggedUser> loginByEmail(CredentialParamsLogin params) async {
    try {
      UserCredential user = await auth.signInWithEmailAndPassword(
        email: params.email, 
        password: params.password
      );

      final userData = await users.doc(user.user?.uid).get();
      final infosUser = InfosUser.fromMap(userData.data() as Map<String, dynamic>);
       
      return LoggedUser(
        email: user.user!.email!,
        name: infosUser.name,
        uid: user.user!.uid,
        phoneNumber: infosUser.phoneNumber
      );
      

    } on FirebaseAuthException catch(e){
      
      if(e.code == "invalid-email"){
        throw InvalidEmail();
      } else if(e.code == "user-not-found"){
        throw UserNotFound();
      } else if(e.code == "wrong-password"){
        throw WrongPassword();
      } else {
        throw Exception();
      }
    } catch (e){
      throw Exception();
    }
  }

  @override
  Future<LoggedUser> singInByGoogle() async{
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount == null) throw UserRejectAuth();

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential googleUserCredential = await auth.signInWithCredential(googleCredential);

      final userData = await users.doc(googleUserCredential.user!.uid).get();

      if(!userData.exists) {
        await users.doc(googleUserCredential.user!.uid).set({
          "name": googleSignInAccount.displayName,
          "phoneNumber": ""
        });
      } else {
        final infosUser = InfosUser.fromMap(userData.data() as Map<String, dynamic>); 
        
        return LoggedUser(
          email: googleUserCredential.user!.email!,
          name: infosUser.name,
          uid: googleUserCredential.user!.uid,
          phoneNumber: infosUser.phoneNumber,
        );
      }

      return LoggedUser(
        email: googleUserCredential.user!.email!,
        name: googleUserCredential.user!.displayName ?? "",
        uid: googleUserCredential.user!.uid,
        phoneNumber: googleUserCredential.user!.phoneNumber ?? "",
      );
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found"){
        throw UserNotFound();
      } else {
        throw Exception();
      }
    } catch (e){
      throw Exception();
    }
  }

  @override
  Future<LoggedUser> getCurrentUser() async {
    try {
      var user = auth.currentUser;
      if(user == null) throw Exception();
      final userData = await users.doc(user.uid).get();
      if(!userData.exists) throw Exception();
      final infosUser = InfosUser.fromMap(userData.data() as Map<String, dynamic>); 
      return LoggedUser(
        email: user.email!, 
        uid: user.uid, 
        name: infosUser.name, 
        phoneNumber: infosUser.phoneNumber
      );
    } catch (e) {
      throw Exception();
    }
  }
}