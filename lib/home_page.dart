
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isOn = false;
  int alarmId = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform.scale(
          scale: 2,
          child: Switch(
            value: isOn,
            onChanged: (value) {
              setState(() {
                isOn = value;
              });
              if (isOn == true) {
                print(DateTime.now());
                AndroidAlarmManager.oneShotAt(
                  // date time format (year,month,date,hour,minutes,seconds)

                  DateTime(2022, 03, 20, 00, 20),
                  alarmId,
                  fireAlarm,
                );
              } else {
                AndroidAlarmManager.cancel(alarmId);
                print('Alarm Timer Canceled');
              }
            },
          ),
        ),
      ),
    );
  }
}

void fireAlarm() {
  print('Vai tomar remedio caralho ');
}
