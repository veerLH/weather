import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:weatherapp/network/api_service.dart';
import './bloc.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {

  final ApiService apiService;

  SearchBloc({@required this.apiService}):assert (apiService != null);

  @override
  SearchState get initialState => CityEmptyState();

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if(event is FetchCityEvent){
      yield CityLoadingState();
      try{
        final response = await apiService.getCities(event.cityName);
        yield CityLoadedState(cityModels: response);
      }on SocketException{
        yield CityErrorState();
      }on Exception {
        yield CityErrorState();
      }

    }
  }
}
