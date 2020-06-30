import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent{
  final int citycode;

  FetchWeather({@required this.citycode}): assert(citycode !=null);

  @override
  // TODO: implement props
  List<Object> get props => [citycode];


}
