import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/My_Theme.dart';

import '../provider.dart';

class ModeSheet extends StatefulWidget
{
  @override
  State<ModeSheet> createState() => _ModeSheetState();
}

class _ModeSheetState extends State<ModeSheet> {
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.appTheme==ThemeMode.dark?getWidgetSelcted('Dark'):getUnWidgetSelcted('Dark'),
          ),
          InkWell(
            onTap: (){
              provider.changeTheme(ThemeMode.light);
            },
              child: provider.appTheme==ThemeMode.light?getWidgetSelcted('Light'):getUnWidgetSelcted('Light'),
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