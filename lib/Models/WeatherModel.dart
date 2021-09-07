import 'package:flutter/material.dart';

class WeatherModel {
  //final
  //int id;
  int weatherId;
  int cityId;
 // final
  String city;
 // final
  String dateTime;
 // final
  String temperature;
  //final
  String weatherType;
  //final
  String iconUrl;
  //final
  String wind;
  //final
  String rain;
  //final
  String humidity;


  WeatherModel({
    required this.weatherId,
    required this.cityId,
    required this.city,
    required this.dateTime,
    required this.temperature,
    required this.weatherType,
    required this.iconUrl,
    required this.wind,
    required this.rain,
    required this.humidity,
  });

  //
  Map toJson() => {
    'weatherId': weatherId,
    'cityId': cityId,
    'city': city,
    'dateTime': dateTime,
    'temperature': temperature,
    'weatherType': weatherType,
    'iconUrl': iconUrl,
    'wind': wind,
    'rain': rain,
    'humidity': humidity,
  };

  // User(Map<String, dynamic> data) {
  //   id = data['id'];
  //   city = data['alias'];
  //   temperature = data['temperature'];
  // }

}

var test = [
  WeatherModel(
      weatherId: 800,
      cityId: 420006353,
      city: "Chennai",
      dateTime: "07:40 PM - Monday, 5 July 2021",
      temperature: "34\u2103",
      weatherType: "Cloudy",
      iconUrl: "assets/cloudy.svg",
      wind: "6",
      rain: "4",
      humidity: "3",
  ),
];

var locationList = [
  // WeatherModel(
  //     id: 800,
  //     city: "Chennai",
  //     dateTime: "07:40 PM - Monday, 5 July 2021",
  //     temperature: "34\u2103",
  //     weatherType: "Cloudy",
  //     iconUrl: "assets/cloudy.svg",
  //     wind: "6",
  //     rain: "4",
  //     humidity: "3",
  // ),

  // WeatherModel(
  //     id: 800,
  //     city: "Chandigarh",
  //     dateTime: "10:40 PM - Monday, 5 July 2021",
  //     temperature: "3\u2103",
  //     weatherType: "Sunny",
  //     iconUrl: "assets/sun.svg",
  //     wind: "16",
  //     rain: "2",
  //     humidity: "1",
  // ),
  //
  // WeatherModel(
  //     city: "Canada",
  //     dateTime: "5:40 PM - Monday, 5 July 2021",
  //     temperature: "-4\u2103",
  //     weatherType: "Rainy",
  //     iconUrl: "assets/rain.svg",
  //     wind: "2",
  //     rain: "6",
  //     humidity: "7",
  // ),
  //
  // WeatherModel(
  //   city: "Chandigarh",
  //   dateTime: "10:40 PM - Monday, 5 July 2021",
  //   temperature: "3\u2103",
  //   weatherType: "Sunny",
  //   iconUrl: "assets/sun.svg",
  //   wind: "16",
  //   rain: "2",
  //   humidity: "1",
  // ),
  
];

final locationName = [];