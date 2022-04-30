import 'package:flutter/material.dart';

import 'modal_cadastro_alarme.dart';



class NovoAlarme extends StatelessWidget {

  // const AddTodoButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Material(
            // color: AppColors.accentColor,
            elevation: 2,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'New todo',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    const TextField(
                      decoration: InputDecoration(
                        hintText: 'Write a note',
                        border: InputBorder.none,
                      ),
                      cursorColor: Colors.white,
                      maxLines: 6,
                    ),
                    const Divider(
                      color: Colors.white,
                      thickness: 0.2,
                    ),
                    // FlatButton(
                    //   onPressed: () {},
                    //   child: const Text('Add'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
