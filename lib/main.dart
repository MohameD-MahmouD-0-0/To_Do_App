import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/Edit_Task.dart';
import 'package:untitled17/Home_Screen.dart';
import 'package:untitled17/Login/Login_Screen.dart';
import 'package:untitled17/My_Theme.dart';
import 'package:untitled17/Setting/Setting.dart';
import 'package:untitled17/auth_provider.dart';
import 'package:untitled17/provider.dart';
import 'package:untitled17/register/Register_Screen.dart';
import 'TaskList/TaskList.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main ()
async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseFirestore.instance.settings=Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  // await FirebaseFirestore.instance.disableNetwork()
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context)=>App_Config()),
    ChangeNotifierProvider(create: (context)=>authProviderd())
  ],
      child: MyApp())
  );
}
class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);

    return  MaterialApp(
      title: 'To Do',
    debugShowCheckedModeBanner: false,
  initialRoute: LoginScreen.routeName,
     routes: {
      Home_Screen.routeName:(context)=>Home_Screen(),
      TaskListTap.routeName:(context)=>TaskListTap(),
      EditTask.routeName:(context)=>EditTask(),
      Setting.routeName:(context)=>Setting(),
      LoginScreen.routeName:(context)=>LoginScreen(),
      RegisterScreen.routeName:(context)=>RegisterScreen(),
    },
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    theme: MyTheme.lightMode,
    darkTheme: MyTheme.DarktMode,
    themeMode: provider.appTheme,
      locale: provider.applocale,
  );
  }
}