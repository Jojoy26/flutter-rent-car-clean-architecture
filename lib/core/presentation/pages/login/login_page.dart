// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/usecases/login_by_email.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_login_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/build_text_form_field.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';
import 'package:flutter_rent/core/presentation/widgets/google_button.dart';
import 'package:get/get.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GetxLoginPresenter controller = Get.put(Modular.get<GetxLoginPresenter>());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 60, right: 15, left: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                alignment: Alignment.centerLeft,
                  child: Text(
                    "Login to your account",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black),
                  ),
                ),
                buildTextFormField(
                  Icon(Icons.email), 
                  "Type your email", 
                  TextInputType.emailAddress,
                  false,
                  emailController,
                  (value){
                    var emailRegex = "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$";
                    if(!RegExp(emailRegex).hasMatch(value as String)){
                      return "Enter a valid email";
                    }
                  }
                ),
                buildTextFormField(
                  Icon(Icons.vpn_key_rounded), 
                  "Type your password", 
                  TextInputType.text,
                  true,
                  passwordController,
                  (value){
                    if(value!.length < 8){
                      return "The password must contain at least 8 letters";
                    }
                  }
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: (){},
                    child: Text("Forgout Password?", style: TextStyle(color: Colors.black87),) 
                  ),
                ),
                customButton("Login", (){
                  if(_formKey.currentState!.validate()){
                    controller.loginByEmail(
                      CredentialParamsLogin(
                        email: emailController.text,
                        password: passwordController.text,
                      )
                    );
                  }
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBB51A),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Text("Or"),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          decoration: BoxDecoration(
                            color: Color(0xFFDBB51A),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                googleButton("Continue with Google", (){
                  controller.singInByGoogle();
                }),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("New in Carento"),
                      SizedBox(width: 3,),
                      TextButton(
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap
                        ),
                        onPressed: (){
                          controller.goToSingUp();
                        },
                        child: Text("Sing Up")
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

