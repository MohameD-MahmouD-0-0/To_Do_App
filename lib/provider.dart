import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'firebasetask.dart';
import 'model/Taskes.dart';

class App_Config extends ChangeNotifier
{
  bool update= false;
   Task  ?task;
  DateTime selectedDate=DateTime.now();
  ThemeMode appTheme = ThemeMode.dark;
  Locale applocale = Locale('en');
  void changeTheme(ThemeMode newMode)
  {
    if(appTheme==newMode)
      {
        return;
      }
    appTheme=newMode;
    notifyListeners();
  }
  void changeLocale(Locale newLocale){
    if(applocale==newLocale)
      {
        return;
      }
    applocale = newLocale;
    notifyListeners();
  }
  List<Task> taskesList=[];
  Future<void> getAllTaskFromFireStore(String uid) async {
    QuerySnapshot<Task>? querySnapshot = await FirebaseUtils.getTaskCollection(uid)?.get();
    taskesList= querySnapshot!.docs.map((doc) {
      return doc.data();
    }).toList();
    taskesList= taskesList.where((task) {
      if(task.dateTime?.day==selectedDate.day&&
          task.dateTime?.month==selectedDate.month&&
          task.dateTime?.year==selectedDate.year){
      return true;
      }
      else
        {
          return false;
        }
    }).toList();
    notifyListeners();
  }
  void setNewSelectDate(DateTime newDate,String uid)
  {
    selectedDate=newDate;
    getAllTaskFromFireStore(uid);
    notifyListeners();
  }
Future<void> setUpdateDate(Task task1,String uid) async {
  task=task1;
  await FirebaseUtils.EditIsTask(task!,uid);
  notifyListeners();
}
void refresh(){
    notifyListeners();
}
  }
//   void setUpdateTitle(Task task){
//     task.title=title;
//   }
// void setUpdateDes(Task task){
//     task.description=des;
// }
// void update(Task task) {
//   task.title= title;
//    task.description= des;
// notifyListeners();
// }
