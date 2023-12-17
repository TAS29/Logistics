import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/bloc/search_result_bloc.dart';

Widget SearchResultListWidget() {
  return BlocBuilder<SearchResultBloc, SearchResultState>(
    builder: (context, state) {
      if (state is SearchResultLoading) {
        // Display a loading indicator while fetching results
        return Center(child: CircularProgressIndicator());
      } else if (state is SearchResultSuccess) {
        if (state.data.value.isEmpty) {
          // Display message when no results found
          return Center(child: Text('No results found.'));
        }

        // Display search results in a ListView
        return ListView.builder(
          itemCount: state.data.value.length,
          itemBuilder: (context, index) {
            var result = state.data.value[index];
            return ListTile(
              title: Text(result.locationName!),
            );
          },
        );
      } else if (state is SearchResultError) {
        // Display an error message if API call fails
        return Center(child: Text('Something Went Wrong!'));
      } else {
        // Initial state or any other state, return an empty container
        return Container();
      }
    },
  );
}