import 'package:dartz/dartz.dart';

import 'package:flutter_rent/commons/networkInfo/network_info.dart';
import 'package:flutter_rent/core/domain/entities/logged_user.dart';
import 'package:flutter_rent/core/domain/errors/userErros/errors.dart';
import 'package:flutter_rent/core/domain/repository/user_repository.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/infra/datasources/user_datasource.dart';

class UserRepositoryImpl implements UserRepository {

  final UserDatasource datasource;
  final NetworkInfo netInfo;

  UserRepositoryImpl({
    required this.datasource,
    required this.netInfo,
  });

  @override
  Future<Either<AuthException, LoggedUser>> singUpByEmail(CredentialParamsSingUp params) async{
    if(await netInfo.isConnected()){
      try {
        final user = await datasource.singUpByEmail(params);
        return Right(user);
      } on EmailAlreadyUse catch(e){
        return Left(e);
      } on WeakPassword catch(e){
        return Left(e);
      } on InvalidEmail catch(e){
        return Left(e);
      } catch (e){
        return Left(SingUpException());
      }
    } 
    return Left(NoInternetConnection());
  }

  @override
  Future<Either<AuthException, LoggedUser>> loginByEmail(CredentialParamsLogin params) async{
    
    if(await netInfo.isConnected()){
      try {
        final user = await datasource.loginByEmail(params);
        return Right(user);
      } on WrongPassword catch(e){
        return Left(e);
      } on UserNotFound catch(e){
        return Left(e);
      } on InvalidEmail catch (e){
        return Left(e);
      } catch (e){
        return Left(LoginException());
      }
    }
    return Left(NoInternetConnection());
  }

  @override
  Future<Either<AuthException, LoggedUser>> singInByGoogle() async{
    if(await netInfo.isConnected()){
      try {
        final user = await datasource.singInByGoogle();
        return Right(user);
      } on UserRejectAuth catch (e) {
        return Left(e);
      } on UserNotFound catch (e){
        return Left(e);
      } catch (e) {
        return Left(SingInByGoogleException());
      }
    }
    return Left(NoInternetConnection());
  }

  @override
  Future<Either<AuthException, LoggedUser>> getCurrentUser() async {
    if(await netInfo.isConnected()){
      try {
        final user = await datasource.getCurrentUser();
        return Right(user);
      } catch (e){
        return Left(GetCurrentUserException());
      }
    }
    return Left(NoInternetConnection());
  }

}
