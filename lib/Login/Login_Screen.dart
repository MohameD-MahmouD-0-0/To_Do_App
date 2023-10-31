import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/Home_Screen.dart';
import 'package:untitled17/My_Theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Dialog.dart';
import '../auth_provider.dart';
import '../custam_text_formFiled/Custam_Text_FormFiled.dart';
import '../firebasetask.dart';
import '../register/Register_Screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var EmailController = TextEditingController(text: 'basil@gmail.com');

  var PasswoedController = TextEditingController(text: '123456');

  var FormKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                      lable:  AppLocalizations.of(context)!.emailLogin,
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
                      lable:  AppLocalizations.of(context)!.passwordLogin,
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      Login();
                    }, child: Text( AppLocalizations.of(context)!.loginButton,style: Theme.of(context).textTheme.titleMedium,)),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Don‘t have an account',style: Theme.of(context).textTheme.titleMedium),
                      TextButton(onPressed: (){
                        Navigator.of(context).pushNamed(RegisterScreen.routeName);
                      }, child: Text('Create Account',style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color:MyTheme.PrimaryLight),))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> Login() async {
    if(FormKey.currentState?.validate()==true)
    {
      DialogUtils.showLoading(context,'Loading');
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: EmailController.text,
            password: PasswoedController.text);
         var user = await FirebaseUtils.readUser(credential.user!.uid);
         if(user==null)
           {
             return;
           }
        var authe = Provider.of<authProviderd>(context,listen: false);
        authe.updateUser(user);
        DialogUtils.closeLoading(context);
        DialogUtils.showMessage(context,title: 'Login success',message: 'Welcome to "TO_DO App"',posActionName: 'OK',posAction: (){
          Navigator.of(context).pushReplacementNamed(Home_Screen.routeName);
        });
        print(credential.user?.uid);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          DialogUtils.showMessage(context,message:'user-not-found',title: 'Error',posActionName: 'OK' );
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessage(context,message:'Wrong password provided for that user.',title: 'Error',posActionName: "OK" );
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
