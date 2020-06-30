import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/bloc/weather/weather_bloc.dart';
import 'package:weatherapp/bloc/weather/weather_event.dart';
import 'package:weatherapp/bloc/weather/weather_state.dart';
import 'package:weatherapp/ui/search_area.dart';
import 'package:weatherapp/utils/helper.dart';


class WeatherHome extends StatefulWidget {
  final int cityCode;

  WeatherHome([this.cityCode = 1015662]);
  @override
  _WeatherHomeState createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {


  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final weatherbloc = BlocProvider.of<WeatherBloc>(context);
    weatherbloc..add(FetchWeather(citycode: widget.cityCode));

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.home),
        title: const Text("Weather Test"),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.search),tooltip: "Search Weather", onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Search_Area()));
          })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: BlocBuilder<WeatherBloc,WeatherState>(builder: (context, state) {
            if(state is LoadingWeatherState){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if(state is LoadedWeatherState){
              return ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("${state.weathersModel.title}",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                          textStyle: Theme.of(context).textTheme.headline2
                      ),),
                      Text("Updated : " + DateTime.parse(state.weathersModel.weathers[0].created).toString()),

                      Padding(padding: EdgeInsets.only(top: 20),
                        child: Image(
                            width: 180.0,
                            image: AssetImage("assets/images/${Helper.mapStringToImage(state.weathersModel.weathers[0].weatherStateAbbr)}.png")),
                      ),
                      Text("${state.weathersModel.weathers[0].weatherStateName}",style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                          textStyle: Theme.of(context).textTheme.headline4
                      ),),
                      Padding(padding: EdgeInsets.only(top: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text("${state.weathersModel.weathers[0].theTemp.toInt()}°C",style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              textStyle: Theme.of(context).textTheme.headline3,
                              color: Colors.redAccent
                          ),),
                          Column(
                            children: <Widget>[
                              Text("min : ${state.weathersModel.weathers[0].minTemp.toInt()}°C",style:
                              TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                              ),),
                              Text("max : ${state.weathersModel.weathers[0].maxTemp.toInt()}°C",style:
                              TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                              ),)
                            ],
                          )
                        ],
                      )
                    ],
                  )
                ],
              );
            }

            return Center(
              child: Text("Null"),
            );
        }),
      ),
    );
  }
}
