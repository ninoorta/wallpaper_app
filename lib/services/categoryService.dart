import 'dart:convert';
import 'dart:io';

import '../models/categories/categories.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String apiURL = "https://mkt.h2c.us/api/v1/wallpaper/category";
  static int categoryID;
  static int pageNumber;
  static String apiChosenCategoryURL = 'https://mkt.h2c.us/api/v1/wallpaper/query?cid=$categoryID&page=$pageNumber';

  static getCategoryData() async {
    // try {
    //   print("running");
    //   final response = await http.get(Uri.parse(apiURL));
    //   if (response.statusCode == 200) {
    //     print("run to here ${response.statusCode}");
    //     print("data when 200: ${response.body}");
    //
    //     var result = jsonDecode(response.body);
    //     // List<CategoryData> finalData = result["data"];
    //     List<CategoryData> finalData = result["data"];
    //
    //     print("final data: $finalData");
    //     return finalData;
    //
    //     // final categoryData = categoryDataFromJson(temp);
    //     // final List<CategoryData> categoryData = jsonDataFromJson(response.body);
    //     // print("data when 200: ${response.body}");
    //     //
    //     // print("categoryData $categoryData");
    //     //
    //     // print("end of 200");
    //     // return categoryData;
    //
    //   }
    //   else {
    //     // print("err");
    //     // return List<CategoryData>();
    //   }
    // } catch (err) {
    //   print("have err $err");
    //   // return List<CategoryData>();
    // }

    print("running");
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      // print("body $bodyDecode");
      // print("data ${bodyDecode["data"]}");
      // print("data ${bodyDecode["data"][0]}");
      return bodyDecode["data"];
      // print(CategoryData.fromJson(jsonDecode(response.body)["data"]));
      // print(CategoryData.fromJson(jsonDecode(response.body)["data"]));
      // return CategoryData.fromJson(jsonDecode(response.body)["data"]);
    }
  }

  static getChosenCategoryData(int categoryID, int pageNumber) async {
    print("start running with getChosenCategoryData");
    final response = await http.get(Uri.parse('https://mkt.h2c.us/api/v1/wallpaper/query?cid=$categoryID&page=$pageNumber'));
    if(response.statusCode == 200){
      var bodyDecode = jsonDecode(response.body);
      // print("chosenCategoryData $bodyDecode");
      return bodyDecode["data"];
    }

  }
}
