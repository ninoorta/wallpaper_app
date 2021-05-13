import 'package:flutter/material.dart';

class Categories {

  static final  _categories = <CategoryModel>[
     CategoryModel(svgIconURL: "assets/icons/category_icons/4k.svg", categoryName: "Ultra HD", categoryRoute: "ultraHD"),
     CategoryModel(svgIconURL: "assets/icons/category_icons/new.svg", categoryName: "New", categoryRoute: "new"),
     CategoryModel(svgIconURL: "assets/icons/category_icons/animals.svg", categoryName: "Animals", categoryRoute: "animals"),
     CategoryModel(svgIconURL: "assets/icons/category_icons/space.svg", categoryName: "Space", categoryRoute: "space"),
     CategoryModel(svgIconURL: "assets/icons/category_icons/nature.svg", categoryName: "Nature", categoryRoute: "nature"),
     CategoryModel(svgIconURL: "assets/icons/category_icons/sports.svg", categoryName: "Sports", categoryRoute: "sports"),
  ];
  
  
  
  List<CategoryModel> getAllCategories(){
    return Categories._categories.map((category) => category).toList();
  }
  
  
  // fetch categories data when have API
}

class CategoryModel {
  final String svgIconURL;
  final String categoryName;
  final String categoryRoute;

  CategoryModel(
      {@required this.svgIconURL,
      @required this.categoryName,
      @required this.categoryRoute});
}
