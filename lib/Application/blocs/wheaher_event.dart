


import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class WheatherEvent extends Equatable {
  const WheatherEvent();
}
class initialEvent extends WheatherEvent{
  final BuildContext context;

  initialEvent(this.context);

  @override
  List<Object?> get props => [context];
}
class GetWheather extends WheatherEvent {
  final String city;

  GetWheather(this.city);

  @override
  List<Object?> get props => [city];
}
