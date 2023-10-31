import 'package:flutter/material.dart';
import 'package:untitled17/My_Theme.dart';
class DialogUtils{
static void showLoading(BuildContext context,String Message)
{
  showDialog(
      context: context, builder: (context){
    return AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
        SizedBox(width: 4,),
        Text(Message)
        ],
      ),
    );
  }
  );
}
static void closeLoading(BuildContext context)
{
  Navigator.pop(context);
}
static void showMessage(BuildContext context,
    { String ?message,
    String? posActionName,
    VoidCallback ?posAction,
    String title='Title'})
{
  List<Widget> actions=[];
  showDialog(context: context,
      builder:(context){
    if(posActionName!.isNotEmpty);
      {
        actions.add(TextButton(onPressed: (){
          Navigator.pop(context);
          posAction?.call();
        }, child:Text(posActionName,style: TextStyle(color:MyTheme.PrimaryLight))
        ));
      }
    return AlertDialog(
      title: Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.PrimaryLight),),
      content:Text(message!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.greenlight),),
      actions: actions,
    );
      }
  );
}
}