import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  String title;
  String value;
  Widget icon;


  RoundedContainer({required this.title, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.black,
      ),
      child: Column(
        children: [
          SizedBox(height: 2,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  title,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          Row(

            children: [
              SizedBox(width: 10,),
              icon,
              SizedBox(width: 15,),
              Text(value,style: TextStyle(color: Colors.white),)
            ],
          )
        ],
      ),
    );
  }
}
