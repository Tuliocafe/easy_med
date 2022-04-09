import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

int alarmId = 1;

// ignore: unused_element
void _examples() {
  // runs alarm timer once with time delay
  AndroidAlarmManager.oneShot(
    Duration(seconds: 5),
    alarmId,
    fireAlarm,
  );
  // runs alarm timer at exact time
  AndroidAlarmManager.oneShotAt(
    // date time format (year,month,date,hour,minutes,seconds)
    DateTime(2022, 03, 19, 23, 20),
    alarmId,
    fireAlarm,
  );
  // runs callback function repeatedly
  AndroidAlarmManager.periodic(
    // must be higher than 60 seconds
    Duration(seconds: 60),
    alarmId,
    fireAlarm,
  );
}

void fireAlarm() {
  print('Alarm Fired at${DateTime.now()}');
}