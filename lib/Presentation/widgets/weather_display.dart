// lib/presentation/widgets/weather_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../Application/services/FirebaeFunctionalities/auth/auth_bloc.dart';
import '../../domain/entities.dart';
import 'RoundedContainer.dart';

class WeatherDisplay extends StatelessWidget {
 String Temp;
 String condition;
 String humidity;
 String windspeed;
 String name;


 WeatherDisplay({required this.Temp, required this.condition, required this.humidity, required this.windspeed,required this.name});

 @override
  Widget build(BuildContext context) {
   print("name $name");
    return
     SingleChildScrollView(

       child: Column(

       children: [
         Row(mainAxisAlignment: MainAxisAlignment.center,children: [
           Text(name,style: TextStyle(color: Colors.black,fontSize: 15,fontStyle: FontStyle.italic),)
         ],),
         Container(
           child: ["Clear","Clouds","Haze","Smoke"].contains(condition)?Lottie.asset("lib/assets/Animations/${condition}.json",repeat: true):Lottie.asset("lib/assets/Animations/Clear.json",repeat: true),),
         SizedBox(height: 100,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             RoundedContainer(title: "Temperature", value: '${Temp}°C', icon: Icon(Icons.thermostat,color: Colors.amber,),),
             RoundedContainer(title: "Condition", value: '${condition}', icon: Icon(Icons.satellite_alt_rounded,color: Colors.green,),),

           ],
         ),
         SizedBox(height: 10,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: [
             RoundedContainer(title: "Humidity", value: '${humidity}', icon: Icon(Icons.water_drop,color: Colors.blue,),),
             RoundedContainer(title: "Wind Speed", value: '${windspeed}', icon: Icon(Icons.wind_power,color: Colors.amber,),),

           ],
         ),

         Padding(
           padding:  EdgeInsets.only(top: 14),
           child: BlocBuilder<AuthBloc, AuthState>(
             builder: (context2, state) {
               if (state is AuthSuccess) {
                 print("state ${state.user?.uid}");

               } else if (state is AuthFailure) {
                 print("state ${state.message}");


               }
               return ElevatedButton(
                 onPressed: () {

                   BlocProvider.of<AuthBloc>(context).add(SignOutRequested(context));
                 },
                 style: ButtonStyle(
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(10.0),
                     ),
                   ),
                 ),
                 child: Text('Sign Out'),
               );
             },
           ),
         ),

       ],
          ),
     );
  }
}
