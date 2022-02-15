import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rent/core/domain/usecases/singup_by_email.dart';
import 'package:flutter_rent/core/presentation/presenters/getx_singup_presenter.dart';
import 'package:flutter_rent/core/presentation/widgets/build_text_form_field.dart';
import 'package:flutter_rent/core/presentation/widgets/custom_button.dart';
import 'package:flutter_rent/core/presentation/widgets/google_button.dart';
import 'package:get/get.dart';


class SingUpPage extends StatefulWidget {
  const SingUpPage({Key? key}) : super(key: key);

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {

  GetxSingUpPresenter controller = Get.put(Modular.get<GetxSingUpPresenter>());

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        controller.goBack();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new_rounded,
                        color: Colors.black,
                  )),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Create an account",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black),
                        ),
                      ),
                      buildTextFormField(
                          Icon(Icons.person), 
                          "Type your name",
                          TextInputType.text,
                          false,
                          nameController,
                          (value){
                            if(value!.length < 2){
                              return "The name must contain at least 2 letters";
                            }
                          }
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
                      buildTextFormField(
                          Icon(Icons.phone),
                          "Type phone number", 
                          TextInputType.number,
                          false,
                          phoneNumberController,
                          (value){
                            if(value!.length < 2){
                              return "The name must contain at least 6 numbers";
                            }
                          }
                        ),
                      SizedBox(
                        height: 25,
                      ),
                      customButton("Sing Up", (){
                        if(_formKey.currentState!.validate()){
                          controller.singUpByEmail(
                            CredentialParamsSingUp(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                              phoneNumber: phoneNumberController.text
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
                                child: Text("Oi"),
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
                                child: Text("Oi"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      googleButton("Sing Up with Google", (){
                        controller.singInByGoogle();
                      }),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?"),
                            SizedBox(width: 3,),
                            TextButton(
                              style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap
                              ),
                              onPressed: (){
                                controller.goBack();
                              },
                              child: Text("Login")
                            )
                          ],
                        ),
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

