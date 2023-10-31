import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/My_Theme.dart';
import 'package:untitled17/Setting/LanguageshowSheet.dart';
import 'package:untitled17/Setting/ModeshowSheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider.dart';

class Setting extends StatefulWidget{
  static const String routeName= 'setting';

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);
    return Scaffold(
          body:Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.language,style:Theme.of(context).textTheme.subtitle2!.copyWith(
                    color:provider.appTheme==ThemeMode.dark?MyTheme.white:MyTheme.blackColor )),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(onPressed: (){
                  showLangbottomSheet();
                }, child: Text('English',textAlign: TextAlign.start,style: Theme.of(context).textTheme.subtitle2?.copyWith(color: MyTheme.white),),style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
    provider.appTheme==ThemeMode.dark?MyTheme.CalenderDarkColor:MyTheme.PrimaryLight), ),
              )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(AppLocalizations.of(context)!.mode,style:Theme.of(context).textTheme.subtitle2!.copyWith(
                    color:provider.appTheme==ThemeMode.dark?MyTheme.white:MyTheme.blackColor )),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ElevatedButton(onPressed: (){
                    showModebottomSheet();
                  }, child: Text(provider.appTheme==ThemeMode.dark?'Dark':'Light',textAlign: TextAlign.start,style: Theme.of(context).textTheme.subtitle2?.copyWith(color: MyTheme.white),),style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        provider.appTheme==ThemeMode.dark?MyTheme.CalenderDarkColor:MyTheme.PrimaryLight), ),
                  )
              ),
            ],
          ),
    );
  }
  void showLangbottomSheet() {
    showModalBottomSheet(context: context, builder: (context)=> LanguageSheet());
  }
  void showModebottomSheet() {
    showModalBottomSheet(context: context, builder: (context)=> ModeSheet());
  }
}