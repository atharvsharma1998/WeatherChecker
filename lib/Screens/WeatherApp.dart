import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/Assistant/PreferencesService.dart';
import 'package:weather_app/Assistant/RequestAssistant.dart';
import 'package:weather_app/Models/WeatherModel.dart';
import 'package:weather_app/Screens/LocationSearch.dart';
import 'package:weather_app/Widgets/PageViewSlider.dart';
import 'package:weather_app/Widgets/SingleWeatherWidget.dart';
import 'package:weather_app/Widgets/buildinTransformer.dart';
import 'package:weather_app/mapKey.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);
  static const String idScreen = "weather";

  @override
  _WeatherAppState createState() => _WeatherAppState();
}



class _WeatherAppState extends State<WeatherApp>  with WidgetsBindingObserver{
  int currentpage = 0;
  late String backgroundImage;
  String place = "nashik";



  final preferenceService = PreferencesService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);

    setState(() {
      preferenceService.getData();
    });

  }
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');

    //final isResumed = state == AppLifecycleState.resumed;
    if (state == AppLifecycleState.resumed){
      setState(() {
        print("inside resumed");
        preferenceService.getData();
        print(locationList);
      });

    }

  }

  onPageChanged(int index){
    setState(() {
      currentpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    if(locationList.length !=0) {
      if (locationList[currentpage].weatherId == 800) {
        setState(() {
          backgroundImage = "assets/sunny.jpg";
        });
      }
      //thunderstorm
      else if (locationList[currentpage].weatherId >= 200 &&
          locationList[currentpage].weatherId <= 232) {
        backgroundImage = "assets/rainy.jpg";
      }
      //drizzle
      else if (locationList[currentpage].weatherId >= 300 &&
          locationList[currentpage].weatherId <= 321) {
        backgroundImage = "assets/rainy.jpg";
      }
      //Rain
      else if (locationList[currentpage].weatherId >= 500 &&
          locationList[currentpage].weatherId <= 531) {
        backgroundImage = "assets/rainy.jpg";
      }
      //Snow
      else if (locationList[currentpage].weatherId >= 600 &&
          locationList[currentpage].weatherId <= 622) {
        backgroundImage = "assets/rainy.jpg";
      }
      //Multiple Atmosphere
      else if (locationList[currentpage].weatherId >= 701 &&
          locationList[currentpage].weatherId <= 781) {
        backgroundImage = "assets/rainy.jpg";
      }
      //Cloudy
      else if (locationList[currentpage].weatherId >= 801 &&
          locationList[currentpage].weatherId <= 804) {
        backgroundImage = "assets/cloudy.jpeg";
      }
      //any other code
      else {
        backgroundImage = "assets/night.jpg";
      }
    }
    else{
      backgroundImage = "assets/night.jpg";
    }



    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        //title: Text("WeatherApp"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () async {
            print("menu pressed");
            setState(() {
              preferenceService.getData();
              print(test);
              print(locationList);
            });

            // var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSearch()));

          },
          icon: Icon(Icons.menu_rounded),
        ),

        actions: [

          Container(
            padding: EdgeInsets.only(right: 15),
            child:
            IconButton(
              onPressed: () async {
                print("search pressed");

                //String url = "https://api.openweathermap.org/data/2.5/weather?q=${place}&appid=${mapKey}"; //reverse geocoding
                //var res = await Navigator.push(context, MaterialPageRoute(builder: (context)=>LocationSearch()));
                //Navigator.push(context, MaterialPageRoute( builder: (context) => LocationSearch()));
                Navigator.push( context, MaterialPageRoute( builder: (context) => LocationSearch()), ).then((value) => setState(() {
                  //print("pushWala");
                  preferenceService.getData();
                }));

                },
              icon: Icon(Icons.add, size: 28,
                color: Colors.white),
            ),
          ),
        ],

      ),
        body: Container(
          child:
          Stack(
            children: [
              Image.asset(
                backgroundImage,
                fit: BoxFit.fill,
                height: double.infinity,
                width: double.infinity,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.black26),
              ),
              Container(
                margin: EdgeInsets.only(top: 110, left: 25),
                child: Row(
                  children: [


                    for(int i = 0; i<locationList.length; i++)
                      if(i == currentpage)
                        PageViewSlider(true)
                      else
                        PageViewSlider(false)


                  ],
                ),
              ),

              NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: PageView.builder(
                  //transformer: ScaleAndFadeTransformer(),
                    //viewportFraction: 0.8,
                    onPageChanged: onPageChanged,
                    scrollDirection: Axis.horizontal,
                    itemCount: locationList.length == 0 ? 1 : locationList.length,
                    itemBuilder: (ctx, i) => SingleWeatherWidget(i),
                ),
              ),

        ],
      ),
    )
    );
  }
}

// var response = await RequestAssistant.getRequest(url);
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
//
//
// print(response);

// class LifecycleEventHandler extends WidgetsBindingObserver {
//   final AsyncCallback resumeCallBack;
//   final AsyncCallback suspendingCallBack;
//
//   LifecycleEventHandler({
//     required this.resumeCallBack,
//     required this.suspendingCallBack,
//   });
//
//   @override
//   Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
//     switch (state) {
//       case AppLifecycleState.resumed:
//         if (resumeCallBack != null) {
//           await resumeCallBack();
//         }
//         break;
//       case AppLifecycleState.inactive:
//       case AppLifecycleState.paused:
//       case AppLifecycleState.detached:
//         if (suspendingCallBack != null) {
//           await suspendingCallBack();
//         }
//         break;
//     }
//   }
// }