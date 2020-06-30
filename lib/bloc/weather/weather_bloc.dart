import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/network/api_service.dart';
import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => EmptyWeatherState();

  final ApiService apiService;
  WeatherBloc({@required this.apiService}):assert(apiService!=null);

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if(event is FetchWeather){
      yield LoadingWeatherState();
        try{
          final response = await apiService.getWeather(event.citycode);
          yield LoadedWeatherState(weathersModel: response);
        }on SocketException{
          yield ErrorWeatherState();
        }on Exception{
          yield ErrorWeatherState();
        }
    }
  }
}
