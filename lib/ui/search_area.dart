import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/bloc/search/search_bloc.dart';
import 'package:weatherapp/bloc/search/search_event.dart';
import 'package:weatherapp/bloc/search/search_state.dart';
import 'package:weatherapp/ui/weather_home.dart';

class Search_Area extends StatefulWidget {
  @override
  _Search_AreaState createState() => _Search_AreaState();
}

class _Search_AreaState extends State<Search_Area> {

  var searchfield;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
   // ignore: close_sinks
   final SearchBloc searchBloc = BlocProvider.of<SearchBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Area"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: TextFormField(
                    validator: (searchfieldvalue){
                      if(searchfieldvalue.isEmpty){
                        return "must enter text";
                      }
                      searchfield=searchfieldvalue;
                      return null;
                    },
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: "Search City",
                      border: OutlineInputBorder()
                    ),
                  )),
                  IconButton(icon: Icon(Icons.search), onPressed: (){
                    if(_formKey.currentState.validate()){
                      searchBloc.add(FetchCityEvent(cityName: searchfield));
                    }

                  }
                  )
                ],
              ),
              Expanded(child: BlocBuilder<SearchBloc,SearchState>(builder: (context, state) {
                if(state is CityEmptyState){
                  return Center(
                    child: Text("Type some city "),
                  );
                }
                if(state is CityLoadingState){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(state is CityLoadedState){
                  return ListView.builder(
                      itemCount: state.cityModels.length,
                      itemBuilder: (BuildContext context,int index) {
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => WeatherHome(state.cityModels[index].woeId)));
                          },
                          child:  Card(
                            child: Container(
                                padding: EdgeInsets.only(top: 20,left: 20,right: 30,bottom: 20),
                                child: Text("${state.cityModels[index].title}",style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  textStyle: Theme.of(context).textTheme.headline6,
                                ),
                                )
                            ),
                          ),
                        );
                      },
                  );

                }
                return Center(
                  child: Text("Data successfull"),
                );
              },))
            ],
          ),
        ),
      )
    );
  }
}
