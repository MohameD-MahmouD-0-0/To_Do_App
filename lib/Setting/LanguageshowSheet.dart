import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider.dart';

class LanguageSheet extends StatefulWidget
{
  @override
  State<LanguageSheet> createState() => _LanguageSheetState();
}

class _LanguageSheetState extends State<LanguageSheet> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                provider.changeLocale(Locale('en'));
              },
              child: provider.applocale==Locale('en')?getWidgetSelcted('English'):
              getUnWidgetSelcted('English'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                provider.changeLocale(Locale('ar'));
              },
              child: provider.applocale==Locale('ar')?getWidgetSelcted('العربيه'):
              getUnWidgetSelcted('العربيه'),
            ),
          ),
        ],
      ),
    );
  }

  Widget getWidgetSelcted(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,style: Theme.of(context).textTheme.subtitle2,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.check,size: 30,),
          )
        ],
      ),
    );
  }

  Widget getUnWidgetSelcted(String text){
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text,style: Theme.of(context).textTheme.subtitle2,)
            ])
    );
  }
}