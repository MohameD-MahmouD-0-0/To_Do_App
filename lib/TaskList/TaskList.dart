import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/auth_provider.dart';
import 'package:untitled17/provider.dart';
import 'package:untitled17/taskWidget.dart';

import '../My_Theme.dart';
import '../model/Taskes.dart';

class TaskListTap extends StatefulWidget {
  static const String routeName = 'TaskList';

  @override
  State<TaskListTap> createState() => _TaskListTapState();
}

class _TaskListTapState extends State<TaskListTap> {
  List<Task> taskesList=[];
  @override
  Widget build(BuildContext context) {
    var provider =Provider.of<App_Config>(context);
    var authe = Provider.of<authProviderd>(context);
    if(provider.taskesList.isEmpty)
      {
        provider.getAllTaskFromFireStore(authe.curentUser!.id!);
      }
    return Column(
      children: [
        CalendarTimeline(
          initialDate: provider.selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add((Duration(days: 365))),
          onDateSelected: (date) {
            provider.setNewSelectDate(date,authe.curentUser!.id!);
            setState(() {
            });
          },
          leftMargin: 20,
          monthColor: provider.appTheme==ThemeMode.dark?MyTheme.white:MyTheme.blackColor,
          dayColor: provider.appTheme==ThemeMode.dark?MyTheme.white:MyTheme.white,
          activeDayColor: MyTheme.white,
          activeBackgroundDayColor: provider.appTheme==ThemeMode.dark?MyTheme.CalenderDarkColor:MyTheme.PrimaryLight,
          dotsColor: MyTheme.white,
          selectableDayPredicate: (date) => true,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskWidget(task: provider.taskesList[index],);
            },
            itemCount: provider.taskesList.length,
          ),
        )
      ],
    );
  }

  }