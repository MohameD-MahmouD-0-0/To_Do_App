import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/My_Theme.dart';

import '../provider.dart';

class CustamTextFormFiled extends StatelessWidget{
  String lable;
  TextInputType KeybordType;
  bool isPassword;
  TextEditingController controller;
  String?Function(String?) myValidator;
  CustamTextFormFiled({required this.lable,this.KeybordType=TextInputType.text
    ,this.isPassword=false,required this.controller,required this.myValidator});
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<App_Config>(context);
    return  Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
    decoration: InputDecoration(
        label: Text(lable,style: Theme.of(context).textTheme.titleMedium?.
        copyWith(color: provider.appTheme==ThemeMode.light?MyTheme.white:MyTheme.blackColor,)),

      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),

      borderSide: BorderSide(color:Theme.of(context).primaryColor,width: 4)),

        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15),

            borderSide: BorderSide(color:Theme.of(context).primaryColor,width: 4)),

    ),

    keyboardType: KeybordType,

      obscureText: isPassword,

    controller: controller,

    validator: myValidator,

  ),
);
  }
}