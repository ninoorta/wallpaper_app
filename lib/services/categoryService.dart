import 'dart:convert';
import 'dart:io';

import '../models/categories/categories.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String apiURL = "https://mkt.h2c.us/api/v1/wallpaper/category";
  static int _categoryID;
  static int _pageNumber;
  static String apiChosenCategoryURL = 'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$_categoryID&page=$_pageNumber';
  static String apiFirstPageCategoryURL = 'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$_categoryID&page=1';

  static getCategoryData() async {
    print("running");
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      // print("body $bodyDecode");
      // print("data ${bodyDecode["data"]}");
      // print("data ${bodyDecode["data"][0]}");
      return bodyDecode["data"];
    }
  }

  static getFirstPageCategoryData(int categoryID) async {
    _categoryID = categoryID;
    print("category data in first page $_categoryID");
    final response = await http.get(Uri.parse(
        'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$_categoryID&page=1&limit=4'));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      return bodyDecode["data"];
    }
  }

  static getChosenCategoryData(int categoryID, int pageNumber) async {
    _categoryID = categoryID;
    _pageNumber = pageNumber;
    print("start running with getChosenCategoryData");
    final response = await http.get(Uri.parse(
        'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$_categoryID&page=$_pageNumber&limit=10'));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      // print("chosenCategoryData $bodyDecode");
      return bodyDecode["data"];
    }
  }


  // new API , have key wallpapers with 5 items here.

  static getImagesInCategory() async {
   final response =  await http.get(Uri.parse("https://mkt.h2c.us/api/v1/wallpaper/home"));
   if(response.statusCode == 200){
     var bodyDecode = jsonDecode(response.body);
     return bodyDecode["data"];
   }
  }

  static loadMoreCategoryData(int categoryID, int pageNumber, int limit) async {
    print('load more category data');
    final response = await http.get(Uri.parse(
        'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$categoryID&page=$pageNumber&limit=$limit'));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      return bodyDecode["data"];
    } else {
      throw Exception("Can not load more category data");
    }
  }
}
