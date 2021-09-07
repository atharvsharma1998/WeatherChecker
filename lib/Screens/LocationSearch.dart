import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/Assistant/PreferencesService.dart';
import 'package:weather_app/Assistant/RequestAssistant.dart';
import 'package:weather_app/Models/WeatherModel.dart';

import '../mapKey.dart';

class LocationSearch extends StatefulWidget {
  const LocationSearch({Key? key}) : super(key: key);
  static const String idScreen = "location";

  @override
  _LocationSearchState createState() => _LocationSearchState();

}

class _LocationSearchState extends State<LocationSearch> {
  TextEditingController locationTextEditingController = TextEditingController();
  final preferenceService = PreferencesService();

// @override
// void initState() {
//     super.initState();
//     preferenceService.getData();
//   }

  //var items = ["chennai", "chandigarh", "canada", "toronto", "nashik", "mohali", "panchkula"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Manage Cities", style: TextStyle(color: Colors.black),),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black,),
          ),

          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: 10),
          //     child: Icon(Icons.),
          //
          //   )
          //
          // ],


        ),

        body: Column(
          children: [
          SizedBox(height: 10,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),

          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: locationTextEditingController,
                  style: TextStyle(fontSize: 15,),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    contentPadding: const EdgeInsets.all(10.0),


                    hintText: "Location",
                    //fillColor: Colors.grey[300],
                    //filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),

                  ),
                ),
              ),
              IconButton(onPressed: () async {
                var locationText = locationTextEditingController.text
                    .toLowerCase();
                var response = await fetchWeather(locationText);
                print(response);

                if (response != "failedResponse") {
                  print("inside pass");

                  setState(() {
                    DateTime now = DateTime.now();
                    String formattedDate = DateFormat('EEEE, d MMM y').format(
                        now);
                    dynamic currentTime = DateFormat.jm().format(
                        DateTime.now());
                    //print(currentTime);
                    print(formattedDate);
                    // var locationText = locationTextEditingController.text.toLowerCase();

                    if (locationName.contains(locationText)) {
                      locationTextEditingController.clear();
                      print("duplicate");
                      AlertDialog alert = AlertDialog(
                        title: Text("Alert"),
                        content: Text("Location Already Present"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("Okay")
                          )
                        ],
                      );
                      showDialog(
                          context: context, builder: (BuildContext context) {
                        return alert;
                      });
                    }
                    else {
                      // print("longitude: " + response["coord"]["lon"].toString());
                      // print("latitude: " + response["coord"]["lat"].toString());
                      // print("Weather id: " + response["weather"][0]["id"].toString());
                      // print("Weather Type: " + response["weather"][0]["main"].toString());
                      // print("Weather Description: " + response["weather"][0]["description"].toString());
                      //
                      // print("temp: " + response["main"]["temp"].toString());
                      // print("humidity: "+response["main"]["humidity"].toString());
                      // print("wind speed: "+response["wind"]["speed"].toString());
                      // //print(response["rain"]);
                      // //print("hi");
                      // if(response["rain"] != null ){
                      //   print("Raining");
                      //   print(response["rain"]["1h"]);
                      // }
                      // else{
                      //   print("Nope");
                      // }
                      // print(response);
                      locationList.add(
                        WeatherModel(
                          weatherId: response["weather"][0]["id"],
                          cityId: response["id"],
                          city: "${locationText}",
                          dateTime: "${currentTime}",
                          temperature: response["main"]["temp"] == null
                              ? "--\u2103"
                              : response["main"]["temp"].toString() + "\u2103",
                          weatherType: "${response["weather"][0]["main"]
                              .toString()}",
                          iconUrl: iconLink(response["weather"][0]["id"]),

                          wind: response["wind"]["speed"].toString(),
                          rain: response["rain"] == null
                              ? "0"
                              : response["rain"]["1h"].toString(),
                          humidity: response["main"]["humidity"].toString(),
                        ),
                      );
                      preferenceService.saveData(locationList);
                      locationName.add(locationTextEditingController.text);
                      locationTextEditingController.clear();
                    }
                  });
                } //["main"]["temp"].toString());
                else {
                  print("inside failed");
                  AlertDialog alert = AlertDialog(
                    title: Text("Alert"),
                    content: Text("City not Present"),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Okay")
                      )
                    ],
                  );
                  showDialog(context: context, builder: (BuildContext context) {
                    return alert;
                  });
                }
              }, icon: Icon(Icons.add, size: 25)),

            ],
          ),

        ),
        SizedBox(height: 5,),
        Expanded(
            child: ReorderableListView(

                onReorder: (int oldIndex, int newIndex) {
                  if (newIndex > oldIndex) {
                    newIndex -= 1;
                  }
                  setState(() {
                    var k = locationList[oldIndex];
                    locationList.removeAt(oldIndex);
                    locationList.insert(newIndex, k);
                    preferenceService.saveData(locationList);
                  });
                },

                children: getListItems(),
            ),

    )
    ],
    ),
    );


  }

  List<Widget> getListItems() => locationList
      .asMap()
      .map((i, item) => MapEntry(i, _buildTenableListTile(item, i)))
      .values
      .toList();

  Widget _buildTenableListTile(WeatherModel item, int index) {
    return Dismissible(
      key: Key(item.cityId.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          locationName.remove(locationList[index].city);
          locationList.removeAt(index);
          preferenceService.saveData(locationList);
        });
      },
      background: Container(color: Colors.red),
      child: ListTile(
        key: ValueKey(item.cityId),
        title: Text(
          '${item.city}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        // subtitle: Text(
        //   '${item.artist} ${item.songId}',
        //   style: TextStyle(
        //     color: Colors.black,
        //   ),
        // ),
        // onTap: () {},
      ),
    );
  }



}

Future<dynamic> fetchWeather(location) async {
  // Imagine that this function is fetching user info from another service or database.
  String url = "https://api.openweathermap.org/data/2.5/weather?q=${location}&appid=${mapKey}&units=metric"; //reverse geocoding
  var response = await RequestAssistant.getRequest(url);
  return response;
}


String iconLink(int id) {
  //Clear/Sunny
  if (id == 800) {
    return "assets/sun.svg";
  }
  //thunderstorm
  else if (id >= 200 && id <= 232) {
    return "assets/rain.svg";
  }
  //drizzle
  else if (id >= 300 && id <= 321) {
    return "assets/rain.svg";
  }
  //Rain
  else if (id >= 500 && id <= 531) {
    return "assets/rain.svg";
  }
  //Snow
  else if (id >= 600 && id <= 622) {
    return "assets/rain.svg";
  }
  //Multiple Atmosphere
  else if (id >= 701 && id <= 781) {
    return "assets/rain.svg";
  }
  //Cloudy
  else if (id >= 801 && id <= 804) {
    return "assets/cloudy.svg";
  }
  //any other code
  else {
    return "assets/sun.svg";
  }
}
