import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/My_Theme.dart';
import 'package:untitled17/TaskList/TaskList.dart';
import 'package:untitled17/TaskList/showAddTaskBottomSheet.dart';
import 'package:untitled17/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'Login/Login_Screen.dart';
import 'Setting/Setting.dart';
import 'auth_provider.dart';

class Home_Screen extends StatefulWidget
{
  static const String routeName= 'Home';

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  int selectedindex=0;

  @override
  Widget build(BuildContext context) {
    var provider= Provider.of<App_Config>(context);
    var authe = Provider.of<authProviderd>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo List ${authe.curentUser?.name}',style:Theme.of(context).textTheme.titleSmall,),
        actions: [
          IconButton(onPressed: (){
            provider.taskesList=[];
            authe.curentUser=null;
            Navigator.pushNamed(context, LoginScreen.routeName);
          }, icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color:  provider.appTheme==ThemeMode.dark?MyTheme.CalenderDarkColor:MyTheme.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selectedindex,
          onTap: (index){
            selectedindex = index;
            setState(() {
            });
          },
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.view_list),label:  AppLocalizations.of(context)!.taskList),
            BottomNavigationBarItem(icon:InkWell(
                child: Icon(Icons.settings)),label:AppLocalizations.of(context)!.setting )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
         showtaskBottomsheet();
      },child: Icon(Icons.add,size: 30,),
        shape: StadiumBorder(side: BorderSide(width: 6,color: MyTheme.white)),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body:tap[selectedindex] ,
    );
  }
  List<Widget> tap=[TaskListTap(),Setting()];
  void showtaskBottomsheet() {
    showModalBottomSheet(context: context, builder: (context)=>showAddTaskBottomSheet());
  }
}