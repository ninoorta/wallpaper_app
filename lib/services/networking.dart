import 'dart:convert';

import 'package:http/http.dart' as http;

const String baseHTTP = "https://mkt.h2c.us";

const categoryURL = "/api/v1/wallpaper/category";
var apiURL = Uri.parse(baseHTTP + categoryURL);


class NetworkHelper{

  final String url;

  NetworkHelper(this.url);

  Future getData() async{
     http.Response response = await http.get(Uri.parse(url));

     if(response.statusCode == 200){
       String data = response.body;

        return await jsonDecode(data);

     } else {
       return(response.statusCode);
     }
  }
}

