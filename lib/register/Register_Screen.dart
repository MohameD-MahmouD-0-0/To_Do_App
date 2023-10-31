import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/Login/Login_Screen.dart';
import 'package:untitled17/firebasetask.dart';
import 'package:untitled17/model/My_User.dart';
import '../Dialog.dart';
import '../auth_provider.dart';
import '../custam_text_formFiled/Custam_Text_FormFiled.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider.dart';
class RegisterScreen extends StatefulWidget {
  static const String routeName = 'Register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var NameController = TextEditingController();

  var EmailController = TextEditingController();

  var PasswoedController = TextEditingController();

  var ConfirmationPasswordController = TextEditingController();

  var FormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<App_Config>(context);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/SIGN IN – 1.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill),
          Form(
            key: FormKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  CustamTextFormFiled(
                      lable:  AppLocalizations.of(context)!.userName,
                      controller: NameController,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Valid Data';
                        } else {
                          return null;
                        }
                      }),
                  CustamTextFormFiled(
                      lable: AppLocalizations.of(context)!.emailReg,
                      controller: EmailController,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Valid Data';}
                        bool emailValid =
                        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if(!emailValid)
                          {
                            'Enter Valid Email';
                          }
                        return null;
                      }),
                  CustamTextFormFiled(
                      lable:  AppLocalizations.of(context)!.passwordReg,
                      controller: PasswoedController,
                      isPassword: true,
                      myValidator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Valid Data';
                        }
                          if(text.length<6)
                            {
                              return 'The Password Should be at least 6 Letters';
                            }
                         else {
                          return null;
                        }
                      }),
                  CustamTextFormFiled(
                      lable:  AppLocalizations.of(context)!.passwordSReg,
                      controller: ConfirmationPasswordController,
                      isPassword: true,
                      myValidator: ( text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'Please Enter Valid Data';
                          }
                        if(text!=PasswoedController.text)
                          {
                            return 'The Password dosent match';
                          }
                         else {
                          return null;
                        }
                      }),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      register();
                    }, child: Text( AppLocalizations.of(context)!.regButton,style: Theme.of(context).textTheme.titleMedium,)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> register() async {
    if(FormKey.currentState?.validate()==true)
      {
        DialogUtils.showLoading(context, 'Loading...');
        try {
          final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: EmailController.text,
            password: PasswoedController.text,
          );
          MyUser myuser=MyUser(id: credential.user?.uid, name: NameController.text, email: EmailController.text);
           await FirebaseUtils.addUserToFireStore(myuser);
          var authe = Provider.of<authProviderd>(context,listen: false);
           authe.updateUser(myuser);
          DialogUtils.closeLoading(context);
          DialogUtils.showMessage(context,message: 'Register Succuessfully',title: 'Success',posActionName: 'Ok',
              posAction: (){ Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          });
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            print('The password provided is too weak.');
          } else if (e.code == 'email-already-in-use') {
            print('The account already exists for that email.');
          }
          DialogUtils.closeLoading(context);
        } catch (e) {
          print(e);
        }
      }
  }
}
