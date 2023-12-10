import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/constants/urls.dart';
import 'package:logistics/main.dart';
import 'package:logistics/models/search_model.dart';


class GetSearchResult with ChangeNotifier {
  SearchModel? data;
  bool loading = true;

  getSearchResult(searchedText) async {
    try {
      loading = true;
      notifyListeners();
      Dio dio = Dio();
      Response res = await dio.get(searchUrl+searchedText+"&amp;limit=20&amp;searchFields=new_locations");
      if (res.statusCode == 200) {
        loading = false;
        data = searchModelFromJson(jsonEncode(res.data));
        notifyListeners();
        return;
      } else if (res.statusCode == 400) {
        data = null;
        loading = true;
        notifyListeners();
        print(res.statusCode.toString());
      }
    } on DioError catch (e) {
      loading = true;
      notifyListeners();
      ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
        const SnackBar(
          content: Text('Error Getting Data!'),
          duration: Duration(seconds: 3),
        ),
      );
      // errorMessage();
      print(e.toString());
    }
  }
}
