import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryService {
  static const String apiURL = "https://mkt.h2c.us/api/v1/wallpaper/category";

  static  getCategoryData() async {
    print("running imageService");
    final response = await http.get(Uri.parse(apiURL));
    if (response.statusCode == 200) {
      var bodyDecode = jsonDecode(response.body);
      return bodyDecode["data"];
    }
  }
}
