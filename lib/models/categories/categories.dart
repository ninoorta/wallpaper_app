import 'package:flutter/material.dart';

class Categories {
  static final _categoriesIcon = <CategoryIconModel>[
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/4k.svg",
        categoryName: "Ultra HD",
        categoryRoute: "ultraHD"),
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/new.svg",
        categoryName: "New",
        categoryRoute: "new"),
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/animals.svg",
        categoryName: "Animals",
        categoryRoute: "animals"),
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/space.svg",
        categoryName: "Space",
        categoryRoute: "space"),
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/nature.svg",
        categoryName: "Nature",
        categoryRoute: "nature"),
    CategoryIconModel(
        svgIconURL: "assets/icons/category_icons/sports.svg",
        categoryName: "Sports",
        categoryRoute: "sports"),
  ];

  List<CategoryIconModel> getAllCategoriesIcon() {
    return Categories._categoriesIcon.map((category) => category).toList();
  }

// fetch categories data when have API
}

class CategoryIconModel {
  final String svgIconURL;
  final String categoryName;
  final String categoryRoute;

  CategoryIconModel(
      {@required this.svgIconURL,
      @required this.categoryName,
      @required this.categoryRoute});
}

// class CategoryModel extends CategoryIconModel {
//   final String category
//
//   CategoryModel(@required);
// }