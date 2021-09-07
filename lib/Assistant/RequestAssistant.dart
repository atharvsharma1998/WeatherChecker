//Helps to make http requests


import 'dart:convert';

import 'package:http/http.dart' as http;

class RequestAssistant{

  static Future<dynamic> getRequest(String url) async{

    //fetch the data
    http.Response response = await http.get(Uri.parse(url));


    try{


      if(response.statusCode == 200){
        //decode the data
        String jsonData = response.body;
        var decodeData = jsonDecode(jsonData);
        print(decodeData);
        return decodeData;
      }

      else{
        return "failedResponse";
      }

    }
    catch(exp){

      return "failedServer";

    }


  }

}