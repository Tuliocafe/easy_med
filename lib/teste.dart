import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';


class ym extends StatefulWidget {
  const ym({Key? key}) : super(key: key);

  @override
  State<ym> createState() => _MyAppState();
}

class _MyAppState extends State<ym> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter alarm clock example'),
        ),
        body: Center(
            child: Column(children: <Widget>[
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Create alarm at 06:42',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    FlutterAlarmClock.createAlarm(06, 42);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Show alarms',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    FlutterAlarmClock.showAlarms();
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Create timer for 42 seconds',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    FlutterAlarmClock.createTimer(42);
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.all(25),
                child: TextButton(
                  child: const Text(
                    'Show Timers',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () {
                    FlutterAlarmClock.showTimers();
                  },
                ),
              ),
            ])),
      ),
    );
  }
}








































//verificar depois o que esse codigo faz, eu esqueci e nao anotei

// import 'package:easy_med/servico/servico_autenticacao_google.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class teste extends StatelessWidget {
//   const teste({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final user = FirebaseAuth.instance.currentUser!;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Parabens'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [Text('Usuario', style: TextStyle(fontSize: 24),),
//             SizedBox(height: 32),
//           CircleAvatar(
//             radius: 40,
//             backgroundImage: NetworkImage(user.photoURL!),
//           ),
//             SizedBox(height: 8,),
//             Text('Name: ' + user.displayName!,style: TextStyle(fontSize: 16)),
//             SizedBox(height: 8,),
//             Text('E-mail: ' + user.email!,style: TextStyle(fontSize: 16)),
//             ElevatedButton(onPressed: () async{
//               final provider = Provider.of<ServicoAutenticacaoGoogle>(context, listen:false);
//               provider.logout();
//             }, child: Text('Logout'))
//           ],
//         ),
//       ),
//     );
//   }
// }
//
