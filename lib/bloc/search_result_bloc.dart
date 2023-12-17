import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logistics/constants/urls.dart';
import 'package:logistics/models/search_model.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultInitial()) {
    on<GetSearchResultEvent>(_getSearchResult);
  }

  Future<void> _getSearchResult(GetSearchResultEvent event, Emitter<SearchResultState> emit) async {
    emit(SearchResultLoading());

    try {
      Dio dio = Dio();
      Response res = await dio.get(searchUrl + event.searchedText + "&limit=20&searchFields=new_locations");

      if (res.statusCode == 200) {
        SearchModel data = searchModelFromJson(jsonEncode(res.data));
        emit(SearchResultSuccess(data));
      } else if (res.statusCode == 400) {
        emit(SearchResultError("Error: ${res.statusCode}"));
      }
    } catch (e,s) {
      print(e.toString());
      print(s.toString());
    emit(SearchResultError("Error: $e"));
    }
  }
}