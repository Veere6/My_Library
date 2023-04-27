import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

import 'package:my_library/Services/Intitlemodel/Intitlemodel.dart';
class Services {

  static String intitle = "https://www.googleapis.com/books/v1/volumes?q=";


  static Future<Intitlemodel> GetBooks(String category,String quary) async {
    String url = "${intitle}${category}:${quary}&maxResults=40";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Intitlemodel user = Intitlemodel.fromJson(data);
      return user;
    }else{
      print(response.body);
      throw Exception('Failed');
    }
  }
}