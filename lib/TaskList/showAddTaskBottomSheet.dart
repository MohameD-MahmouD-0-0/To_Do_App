import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/auth_provider.dart';
import 'package:untitled17/model/Taskes.dart';
import '../Dialog.dart';
import '../My_Theme.dart';
import '../firebasetask.dart';
import '../provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class showAddTaskBottomSheet extends StatefulWidget
{
  @override
  State<showAddTaskBottomSheet> createState() => _showAddTaskBottomSheetState();
}

class _showAddTaskBottomSheetState extends State<showAddTaskBottomSheet> {
  DateTime selectedDate=DateTime.now() ;
  String title='';
  String description='';
  var FormKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);
    return Container(
      color:provider.appTheme==ThemeMode.light?MyTheme.white:MyTheme.CalenderDarkColor,
    child: Form(
      key: FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( AppLocalizations.of(context)!.addNewTask,style: Theme.of(context).textTheme.subtitle2?.copyWith(
                color:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white),textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (text)
              {
                title= text;
              },
              decoration: InputDecoration(hintText: AppLocalizations.of(context)!.newTask,hintStyle: TextStyle(   color:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white)),
              validator: (text)
              {
                if(text==null|| text.isEmpty)
                  {
                    return 'please enter valid data';
                  }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (text)
                {
                  description= text;
                },
              decoration: InputDecoration(hintText:AppLocalizations.of(context)!.newTaskDes,hintStyle: TextStyle( color:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white)),
            maxLines: 3,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'please enter valid data';
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(AppLocalizations.of(context)!.selectDate,style: Theme.of(context).textTheme.subtitle1?.copyWith(color:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white ),
              textAlign: TextAlign.start,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                showCalender();
              },
                child: Text('${selectedDate.day}/ ${selectedDate.month}/ ${selectedDate.year}',style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white ),textAlign: TextAlign.center,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              addTask();
            }, child: Row(
              children: [
                Expanded(
                  child: Text(AppLocalizations.of(context)!.addbutton,textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,),
                ),
              ],
            )),
          )
        ],
      ),
    ),
  );
  }
  void showCalender() async{
    var chosenDate =await  showDatePicker(context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(), lastDate: DateTime.now().add(Duration(days: 365)));
    if(chosenDate!=null)
      {
        selectedDate= chosenDate;
      }
    setState(() {
    });
  }
  Future<void> addTask () async {
    if(FormKey.currentState?.validate()==true)
      {
        Task task=Task(title: title,
            dateTime: selectedDate,
            description: description);
        var provider= Provider.of<App_Config>(context,listen: false);
        var authe =Provider.of<authProviderd>(context,listen: false);
        DialogUtils.showLoading(context, 'Loading...');
         await FirebaseUtils.addTaskToFireBase(task,authe.curentUser!.id!)?.then((value) {
           DialogUtils.closeLoading(context);
           provider.setNewSelectDate(DateTime.now(), authe.curentUser!.id!);
           Navigator.pop(context);
           setState(() {
           });
         }
         );
      }
  }
}