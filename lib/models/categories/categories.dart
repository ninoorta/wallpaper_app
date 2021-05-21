import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/services/networking.dart';
import 'package:http/http.dart' as http;
import '../../services/base.dart';

const categoryURL = "/api/v1/wallpaper/category";
var apiURL = baseHTTP + categoryURL;
// var client = http.Client();

class CategoryModel {
  final int categoryID;
  final String categoryName;
  final String categoryThumbFile;
  final String categoryIconFile;

  // final List<CategoryModel> _categoryData;

  CategoryModel(
      {@required this.categoryID,
      @required this.categoryName,
      @required this.categoryThumbFile,
      @required this.categoryIconFile});

   factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
        categoryID: json['id'],
        categoryName: json['name'],
        categoryThumbFile: json['thumb'],
        categoryIconFile: json['icon']);
  }

  Map<String, dynamic> toJson() => {

  };

  // CategoryModel.fromJson(Map<String, dynamic> json)
  // : id = json['id'],

// fetch categories data when have API
//   static Future<List<CategoryModel>> getCategoryData() async {
//     final response = await http.get(apiURL);
//     if (response.statusCode == 200) {
//       // get data
//       var resultParse = jsonDecode(response.body);
//       var categoryData = resultParse["data"];
//       print("category data: $categoryData");
//       return categoryData;
//     } else {
//       throw Exception("error cannot get category data");
//     }
//   }

  static Future<dynamic> getCategoryData() async {
    NetworkHelper networkHelper = NetworkHelper(apiURL);

    var categoryData = await networkHelper.getData();
    return categoryData;
  }

// Future<Category> getCategoryData() async {
//   final response = await
// }

}



// To parse this JSON data, do
//
//     final categoryData = categoryDataFromJson(jsonString);

List<CategoryData> categoryDataFromJson(String str) => List<CategoryData>.from(json.decode(str).map((x) => CategoryData.fromJson(x)));

String categoryDataToJson(List<CategoryData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryData {
  CategoryData({
    this.categoryID,
    this.categoryName,
    this.categoryThumbLink,
    this.categoryIconLink,
  });

  int categoryID;
  String categoryName;
  String categoryThumbLink;
  String categoryIconLink;

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    categoryID: json["id"],
    categoryName: json["name"],
    categoryThumbLink: json["thumb"],
    categoryIconLink: json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": categoryID,
    "name": categoryName,
    "thumb": categoryThumbLink,
    "icon": categoryIconLink,
  };
}
