// lib/presentation/screens/home_screen.dart
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wheather/Application/blocs/wheaher_bloc.dart';
import 'package:wheather/Application/blocs/wheaher_event.dart';
import 'package:wheather/Application/blocs/wheaher_state.dart';
import '../../widgets/Dialog.dart';
import '../../widgets/dialogBox.dart';
import '../../widgets/weather_display.dart';

class HomeScreen extends StatelessWidget {
  late var connectivityResult;
  @override
  Widget build(BuildContext context) {
    Timer.periodic(Duration(milliseconds: 500), (timer) async {
      connectivityResult = await Connectivity().checkConnectivity();

    });

    BlocProvider.of<WheaherBloc>(context).add(initialEvent(context));
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Center(
        child: BlocBuilder<WheaherBloc, WheatherState>(
          builder: (context, state) {
            if (state is WeatherInitial) {
            
              return Text('Enter a city to get the weather.');
            } else if (state is WeatherLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is WeatherLoaded) {

              return WeatherDisplay(Temp: state.weather.temperature.toString(), condition: state.weather.condition.toString(), humidity: state.weather.humidity, windspeed: state.weather.windSpeed, name: state.weather.Name,);


            } else if (state is WeatherError) {
              return WeatherDisplay(Temp: state.weather.temperature.toString(), condition: state.weather.condition.toString(), humidity: state.weather.humidity, windspeed: state.weather.windSpeed, name: state.weather.Name,);
            } else {
              return Text('Unknown state');

            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
           if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
             // Trigger the weather fetch event
             showDialog(
               context: context,
               builder: (BuildContext contextt) {
                 return CustomDialog(context);
               },
             );
           }else{
             showDialog(
               context: context,
               builder: (BuildContext contextt) {
                 return CustomDialogBox(title: "No Netwrok", content: "No Internet Connection", onClosePressed: () { Navigator.pop(context); },);

               },
             );
           }
        },
        child: Icon(Icons.cloud),
      ),
    );
  }
}
