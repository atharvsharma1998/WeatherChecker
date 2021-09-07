import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/Models/WeatherModel.dart';


class SingleWeatherWidget extends StatefulWidget{
  final int index;
  SingleWeatherWidget(this.index);


  @override
  _SingleWeatherWidgetState createState() => _SingleWeatherWidgetState();
}

class _SingleWeatherWidgetState extends State<SingleWeatherWidget> {
  var _locationList = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      _locationList = locationList;
    });
    return
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
//First Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      SizedBox(height: 130,),
                      Text(_locationList.length != 0 ? _locationList[widget.index].city : "City",style: GoogleFonts.openSans(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                      //SizedBox(height: 3,),
                      Text(_locationList.length != 0 ? _locationList[widget.index].dateTime : "DateTime",style: GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),

                    ],
                  ),
                  //Second Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //SizedBox(height: 100,),
                      Text(_locationList.length != 0 ? _locationList[widget.index].temperature : "--\u2103",style: GoogleFonts.openSans(fontSize: 75,fontWeight: FontWeight.w200,color: Colors.white)),
                      Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SvgPicture.asset(_locationList.length != 0 ? _locationList[widget.index].iconUrl : "assets/rain.svg", width: 30,height: 30,color: Colors.white,),
                          SizedBox(width: 10,),
                          Text(_locationList.length != 0 ? _locationList[widget.index].weatherType : "Rainy",style: GoogleFonts.openSans(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
                        ],
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20,bottom: 20),
                  child: Divider(color: Colors.white54, thickness: 1,),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(

                          children:[
                            Text("Wind",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text(_locationList.length != 0 ? _locationList[widget.index].wind.toString() : "-",style: GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text("km/h",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            SizedBox(height: 2,),
                            Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white54,
                                    borderRadius: BorderRadius.circular(5),

                                  ),
                                  height: 5,
                                  width: 50,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(5)
                                  ),
                                  height: 5,
                                  width: 35,
                                  // color: Colors.green,
                                ),



                              ],
                            )
                          ]
                      ),

                      Column(
                          children:[
                            Text("Rain",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text(_locationList.length != 0 ? _locationList[widget.index].rain.toString() : "-",style: GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text("mm",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            SizedBox(height: 2,),
                            Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    height: 5,width: 50),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(5),

                                  ),
                                  height: 5,width: 5,),



                              ],
                            )
                          ]
                      ),

                      Column(
                          children:[
                            Text("Humidity",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text(_locationList.length != 0 ? _locationList[widget.index].humidity.toString() : "-",style: GoogleFonts.openSans(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
                            Text("percent",style: GoogleFonts.openSans(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.white)),
                            SizedBox(height: 2,),
                            Stack(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white54,
                                      borderRadius: BorderRadius.circular(5),

                                    ),
                                    height: 5,width: 50),
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    height: 5,width: 5),
                              ],
                            )
                          ]
                      ),

                    ],
                  ),
                ),
              ],
            ),

          ],
        ),
    );
  }
}
