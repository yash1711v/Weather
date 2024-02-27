import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/Application/services/LocalStorage/SharedPref/SharedPref.dart';

import '../../Application/blocs/wheaher_bloc.dart';
import '../../Application/blocs/wheaher_event.dart';

// [Clear,Clouds,Haze,Smoke]
class CustomDialog extends StatelessWidget {
  BuildContext con;

  CustomDialog(this.con);

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter your City'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: textController,
            decoration: InputDecoration(labelText: 'For e.g. ghaziabad'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              SharedPref().setCity(textController.text.trim());
              Navigator.pop(context);
              BlocProvider.of<WheaherBloc>(con).add(GetWheather(textController.text.trim()));

              // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}