import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialogBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onClosePressed;

  CustomDialogBox({
    required this.title,
    required this.content,
    required this.onClosePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyText1?.color,
                fontSize: 20.0,
              ),
            ),
            SizedBox(height: 20.0),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16.0,color: Theme.of(context).textTheme.bodyText1?.color),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: onClosePressed,
              child: Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}