import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weatherapp/network/model/models.dart';

abstract class SearchState extends Equatable {
  const SearchState();
  @override
  List<Object> get props => [];
}

class CityEmptyState extends SearchState {

}

class CityLoadingState extends SearchState{

}

class CityLoadedState extends SearchState{
    final List<CityModel> cityModels;

    CityLoadedState({@required this.cityModels}) : assert ( cityModels != null );
  List<Object> get props => [cityModels];

}

class CityErrorState extends SearchState{

}
