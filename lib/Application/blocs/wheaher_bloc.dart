import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:wheather/Application/blocs/wheaher_event.dart';
import 'package:wheather/Application/blocs/wheaher_state.dart';
import 'package:wheather/Application/services/LocalStorage/SharedPref/SharedPref.dart';

import '../../Domain/entities.dart';
import '../../Infrastrcture/repositories.dart';




class WheaherBloc extends Bloc<WheatherEvent, WheatherState> {
  final WheatherRepository _weatherRepository;

  WheaherBloc(this._weatherRepository) : super(WheatherInitial()) {
    on<WheatherEvent>((event, emit) async {
      String cityname=await SharedPref().getCity();

      if (event is GetWheather) {
         cityname=event.city;
        emit (WeatherLoading());
        try {
          final weather = await _weatherRepository.getWeather(cityname);
          Future.delayed(Duration(seconds: 1),() async {
            await SharedPref().setCity(cityname);
          await SharedPref().setCondition(weather.condition);
          await SharedPref().setWindSpeed(weather.windSpeed);
          await SharedPref().setHumidity(weather.humidity);
          await SharedPref().setTempe(weather.temperature.toString());});
          emit (WeatherLoaded(weather));
        } catch (e) {
          String name = await SharedPref().getCity();
          String tempe=await SharedPref().getTempe();
          String condition=await SharedPref().getCondition();
          String humidity=await SharedPref().getHumidity();
          String windspeed=await SharedPref().getWindSpeed();
          final weather = Wheather(temperature: double.parse(tempe), condition: condition, humidity: humidity, windSpeed: windspeed, Name: name);
          emit (WeatherError('Failed to fetch weather data',weather));
        }
      }else if(event is initialEvent){
        String city = await SharedPref().getCity();
        print("City name---> $city");
        BlocProvider.of<WheaherBloc>(event.context).add(GetWheather(city));
      }
    });
  }
}
