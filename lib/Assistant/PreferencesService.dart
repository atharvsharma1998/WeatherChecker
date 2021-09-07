import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Models/WeatherModel.dart';
import 'package:weather_app/Screens/LocationSearch.dart';

class PreferencesService{

void saveData(List<dynamic> data) async{
  final preferences = await SharedPreferences.getInstance();

  // var encodedData = json.encode(data);
  // await preferences.setString("weather_data", encodedData);
  //
  // var decodedData = await json.decode(preferences.getString("weather_data") ?? "");
  //
  // print(decodedData);
  //print(data);
  String encodedData = jsonEncode(data);
  print(data);

  //var encodedData = jsonEncode(data.map((e) => e.toJson()).toList());
  print("data encoded");

  await preferences.setString("weather_data", encodedData);
  print("saved to preferences");

  var decodedData = await json.decode(preferences.getString("weather_data") ?? "");
  //var decodedData = json.decode(jsonData);
  print("Data decoded");

  print(decodedData);

}

void getData() async{
  final preferences = await SharedPreferences.getInstance();

  var jsonData = preferences.getString("weather_data");
  print("saved json data");
  print(jsonData);

  if (jsonData == null){
    locationList = [];
  }
  else{
    locationList.clear();
    var dataList = json.decode(jsonData);
    for (var e in dataList) {
      print("blar");
      //print(e);
      //print(e['iconUrl']);
      // if (e['iconUrl'] is int){
      //   print("INT");
      // }
      // else if(e['iconUrl'] is String){
      //   print("String");
      // }
      // else{
      //   print("not int");
      // }
      locationList.add(
          WeatherModel(
            weatherId: e["weatherId"],
            cityId: e["cityId"],
            city: e["city"],
            dateTime: e["dateTime"],
            temperature: e["temperature"],
            weatherType: e["weatherType"],
            iconUrl: e["iconUrl"],
            wind: e["wind"],
            rain: e["rain"],
            humidity: e["humidity"],
          )
      );
      print("fetching Data");
      print(locationList);

  }
  }

}

}