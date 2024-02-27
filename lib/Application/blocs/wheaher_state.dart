

import 'package:flutter/cupertino.dart';

import '../../Domain/entities.dart';

@immutable
abstract class WheatherState {}

class WheatherInitial extends WheatherState {}


class WeatherInitial extends WheatherState {

  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WheatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoaded extends WheatherState {
  final Wheather weather;

  WeatherLoaded(this.weather);

  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WheatherState {
  final Wheather weather;
  final String message;

  WeatherError(this.message,this.weather);

  @override
  List<Object?> get props => [message];
}