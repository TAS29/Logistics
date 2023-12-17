import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logistics/bloc/search_result_bloc.dart'; // Import your bloc file
import 'package:logistics/constants/theme_constants.dart';
import 'package:logistics/widgets/search_result_list_widget.dart';

class SearchCitiesPage extends StatefulWidget {
  @override
  _SearchCitiesPageState createState() => _SearchCitiesPageState();
}

class _SearchCitiesPageState extends State<SearchCitiesPage> {
  // Controller for the search bar
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ThemeConstants.black,
        appBar: AppBar(
          title: Text('Home Page'),
          backgroundColor: ThemeConstants.red,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search bar with onChange listener for real-time updates
              TextField(
                controller: _searchController,
                onChanged: (val) {
                  // Dispatch the event to trigger API call when the user enters more than 2 characters
                  if (val.length > 2) {
                    context.read<SearchResultBloc>().add(GetSearchResultEvent(val));
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search Cities',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      // Dispatch the event to trigger API call when the search icon is pressed
                      if (_searchController.text.length > 2) {
                        context.read<SearchResultBloc>().add(GetSearchResultEvent(_searchController.text));
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: SearchResultListWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
