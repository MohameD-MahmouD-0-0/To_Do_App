import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled17/provider.dart';
import 'My_Theme.dart';
import 'auth_provider.dart';
import 'firebasetask.dart';
import 'model/Taskes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'Edit';

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  String ?title;
  String ?decrip;
  Task? task;

@override
  void initState() {
    super.initState();
    task= ModalRoute.of(context)?.settings.arguments as Task;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      task?.title = title;
      task?.description = decrip;
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<App_Config>(context);
    var authe = Provider.of<authProviderd>(context);

    task = ModalRoute
        .of(context)
        ?.settings
        .arguments as Task;
    return Scaffold(
      backgroundColor: provider.appTheme == ThemeMode.light
          ? MyTheme.backgroundLigth
          : MyTheme.backgroundDark,
      appBar: AppBar(
        title: Text('To Do List', style: Theme
            .of(context)
            .textTheme
            .subtitle2),
      ),
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: provider.appTheme == ThemeMode.light
              ? MyTheme.white
              : MyTheme.CalenderDarkColor,
        ),
        margin: EdgeInsets.symmetric(
          horizontal: MediaQuery
              .of(context)
              .size
              .width * 0.08,
          vertical: MediaQuery
              .of(context)
              .size
              .height * 0.08,
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context)!.editTask,
                style: Theme
                    .of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(
                  color: provider.appTheme == ThemeMode.light
                      ? MyTheme.blackColor
                      : MyTheme.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  title = text;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.editTitle,
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                    color: provider.appTheme == ThemeMode.light
                        ? MyTheme.blackColor
                        : MyTheme.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (text) {
                  decrip = text;
                },
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.editDes,
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(
                    color: provider.appTheme == ThemeMode.light
                        ? MyTheme.blackColor
                        : MyTheme.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                AppLocalizations.of(context)!.editSelectDate,
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle2
                    ?.copyWith(
                  color: provider.appTheme == ThemeMode.light
                      ? MyTheme.blackColor
                      : MyTheme.white,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                '18-9-2023',
                style: Theme
                    .of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(
                  color: MyTheme.greyColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      task?.title = title;
                      task?.title = decrip;
                      FirebaseUtils.EditIsTask(task!, authe.curentUser!.id!);
                      Navigator.pop(context);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.editButton,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}