import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp/bloc/search/search_bloc.dart';
import 'package:weatherapp/network/api_service.dart';
import 'package:weatherapp/ui/weather_home.dart';
import 'package:weatherapp/utils/simple_bloc_delegate.dart';

import 'bloc/weather/weather_bloc.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = "Weather Testing";
  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
        create: (context) => ApiService.created(),
        child: Consumer<ApiService>(builder: (context, apiService, child) {
            return MultiBlocProvider(
                providers:[
                  BlocProvider<WeatherBloc> (
                    create: (context) => WeatherBloc(apiService: apiService),
                  ),
                  BlocProvider<SearchBloc> (
                    create: (context) => SearchBloc(apiService: apiService),
                  )
                ], child: MaterialApp(
                  title: _title,
                  theme: ThemeData(
                    primaryColor: Colors.orangeAccent
                  ),
                  home: WeatherHome(),
            ));
          }
    ),
    );;
  }
}