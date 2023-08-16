import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lhhj/page/login/myLoginPage.dart';
import 'package:lhhj/page/myTest.dart';
//import 'package:background_fetch/background_fetch.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:lhhj/util/myHttp.dart';

import 'package:lhhj/util/navigation_icon_view.dart';


void main() {
  SharedPreferences.setMockInitialValues({});
  HttpOverrides.global = MyHttpOverrides();
  runApp(MyApp());
  // Register to receive BackgroundFetch events after app is terminated.
  // Requires {stopOnTerminate: false, enableHeadless: true}
 // BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
 // BackgroundFetch.start();
}

class MyApp extends StatefulWidget  {
  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
  bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];
  @override
  void initState() {
    super.initState();


  }
  @override
  Widget build(BuildContext context) {
//BackgroundFetch

    return MaterialApp(

      home:
     // ItemsWidget(),
      myLoginPage(loginmode: 0,title: "login", key: null,),
      //TabNavigator(),//

      //myHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,   // 设置主题颜色
      ),
    );
  }
 /*Future<void> initPlatformState() async {
    print("[BackgroundFetch-------------32] ");
    // Configure BackgroundFetch.
    int status = await BackgroundFetch.configure(BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        enableHeadless: true,
        requiresBatteryNotLow: false,
        requiresCharging: false,
        requiresStorageNotLow: false,
        requiresDeviceIdle: false,
        requiredNetworkType: NetworkType.NONE
    ), (String taskId) async {  // <-- Event handler
      // This is the fetch-event callback.
      print("[BackgroundFetch-------------11] Event received $taskId");
      setState(() {
        _events.insert(0, new DateTime.now());
      });
      // IMPORTANT:  You must signal completion of your task or the OS can punish your app
      // for taking too long in the background.
      switch (taskId) {
        case 'com.transistorsoft.customtask':
          print("Received custom task============99");
          break;
        default:
          print("Default fetch task===========99");
      }
      BackgroundFetch.finish(taskId);
    }, (String taskId) async {  // <-- Task timeout handler.
      // This task has exceeded its allowed running-time.  You must stop what you're doing and immediately .finish(taskId)
      print("[BackgroundFetch------------------12] TASK TIMEOUT taskId: $taskId");
      BackgroundFetch.finish(taskId);
    });
    print('[BackgroundFetch-----------------13] configure success: $status');
    setState(() {
      _status = status;
    });

    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.transistorsoft.customtask",
        delay: 5000  // <-- milliseconds
    ));
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }*/
/*
  Future<void> initPlatformState() async {
    BackgroundFetch.configure(BackgroundFetchConfig(
      minimumFetchInterval: 10,
      forceAlarmManager: true,
      stopOnTerminate: false,
      startOnBoot: true,
      enableHeadless: true,
      requiresBatteryNotLow: true,
      requiresCharging: false,
      requiresStorageNotLow: true,
      requiresDeviceIdle: false,
      requiredNetworkType: NetworkType.NONE,
    ), _onBackgroundFetch,_onBackgroundFetchTimeout).then((int status){
      print('[BackgroundFetch-----1] configure success: $status');
    }).catchError((e) {
      print('[BackgroundFetch---------2] configure ERROR: $e');
    });
//_onBackgroundFetchTimeout  UNMETERED
    BackgroundFetch.scheduleTask(TaskConfig(
        taskId: "com.lhhj.myBakTask",
        delay: 10000,
        periodic: false,
        forceAlarmManager: true,
        stopOnTerminate: false,
        enableHeadless: true
    ));
  }

  */
 /* void _onBackgroundFetchTimeout(String taskId) {
    print("[BackgroundFetch---------3] TIMEOUT: $taskId");
    BackgroundFetch.finish(taskId);
  }

  void _onBackgroundFetch(String taskId) async {
    DateTime timestamp = DateTime.now();
    print("[BackgroundFetch-------4] Event received: $taskId@$timestamp");

    if (taskId == "myflutter_background_fetch") {
      // Schedule a one-shot task when fetch event received (for testing).
      BackgroundFetch.scheduleTask(TaskConfig(
          taskId: "com.lhhj.myBakTask",
          delay: 5000,
          periodic: false,
          forceAlarmManager: true,
          stopOnTerminate: false,
          enableHeadless: true
      ));
    }

    // IMPORTANT:  You must signal completion of your fetch task or the OS can punish your app
    // for taking too long in the background.
    BackgroundFetch.finish(taskId);
  }
*/

}
/*
@pragma('vm:entry-point')
void backgroundFetchHeadlessTask(HeadlessTask task) async {
  String taskId = task.taskId;
  bool isTimeout = task.timeout;
  print('[BackgroundFetch------------001] Headless event received.');
  if (isTimeout) {
    // This task has exceeded its allowed running-time.
    // You must stop what you're doing and immediately .finish(taskId)
    print("[BackgroundFetch-----------000] Headless task timed-out: $taskId");
    BackgroundFetch.finish(taskId);
    return;
  }
  print('[BackgroundFetch------------002] Headless event received.');
  // Do your work here...
  BackgroundFetch.finish(taskId);


  if (taskId == 'myflutter_background_fetch') {
    print("your_task_id"+taskId);
    print("[BackgroundFetch-------------004] Headless event received.");
    //await AutoRefresh.fetchAndUpdateAllBooks();
  }
}*/
/*
void backgroundFetchHeadlessTask(String taskId) async {
  DateTime timestamp = DateTime.now();
  print("[BackgroundFetch] Headless event received: $taskId@$timestamp");
  BackgroundFetch.finish(taskId);

  if (taskId == 'myflutter_background_fetch') {
    print("your_task_id");
    print("[BackgroundFetch] Headless event received.");
    //await AutoRefresh.fetchAndUpdateAllBooks();
  }
}*/
