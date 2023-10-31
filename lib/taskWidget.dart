import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/Edit_Task.dart';
import 'package:untitled17/model/Taskes.dart';
import 'package:untitled17/provider.dart';
import 'My_Theme.dart';
import 'auth_provider.dart';
import 'firebasetask.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({required this.task});
  static const String routeName='taskWidget';

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<App_Config>(context);
    var authe = Provider.of<authProviderd>(context);
    return Container(
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(12), topLeft: Radius.circular(12)),
              onPressed: (context) {
                var authe = Provider.of<authProviderd>(context, listen: false);
                FirebaseUtils.deleteFromFireStore(
                    widget.task, authe.curentUser!.id!)
                    ?.timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('To DO deleted success');
                  provider.getAllTaskFromFireStore(authe.curentUser!.id!);
                });
                provider.setNewSelectDate(DateTime.now(), authe.curentUser!.id!);
              },
              backgroundColor: MyTheme.redColor,
              foregroundColor: MyTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(EditTask.routeName,arguments: widget.task);
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: provider.appTheme == ThemeMode.light
                  ? MyTheme.white
                  : MyTheme.CalenderDarkColor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: MyTheme.PrimaryLight,
                    height: 80,
                    width: 4,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.task.title!,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: widget.task.isDone==true?MyTheme.greenlight:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white))),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(widget.task.description!,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: widget.task.isDone==true?MyTheme.greenlight:provider.appTheme==ThemeMode.light?MyTheme.blackColor:MyTheme.white))
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.task.isDone = !widget.task.isDone;
                    FirebaseUtils.EditIsDone(widget.task, authe.curentUser!.id!);
                      setState(() {
                      });
                  },
                  child: widget.task.isDone==false? Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    margin: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: MyTheme.PrimaryLight,
                        borderRadius: BorderRadius.circular(12)),
                    child: Icon(
                      Icons.check,
                      size: 30,
                      color: MyTheme.white,
                    )
                  ):Text(widget.task.title!,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: MyTheme.greenlight),) ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
