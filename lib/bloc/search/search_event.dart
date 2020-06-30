import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();
}

class FetchCityEvent extends SearchEvent{
  final String cityName;

  FetchCityEvent({@required this.cityName}) :assert ( cityName != null);

  @override
  // TODO: implement props
  List<Object> get props => [cityName];
}