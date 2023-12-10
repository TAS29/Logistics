import 'package:flutter/material.dart';
import 'package:logistics/constants/theme_constants.dart';
import 'package:logistics/repo/get_search_result.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                onChanged: (val) async {
                  // Trigger API call when the user enters more than 2 characters
                  if (val.length > 2) {
                    await context.read<GetSearchResult>().getSearchResult(val);
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () async {
                      // Trigger API call when the search icon is pressed
                      if (_searchController.text.length > 2) {
                        await context.read<GetSearchResult>().getSearchResult(_searchController.text);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: _buildSearchResults(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget to display search results
  Widget _buildSearchResults() {
    if (context.watch<GetSearchResult>().data?.value.isEmpty ?? true) {
      // Display message when no results found
      return Center(
        child: Text(context.watch<GetSearchResult>().data == null ? "" : 'No results found.'),
      );
    }

    // Display search results in a ListView
    return ListView.builder(
      itemCount: context.watch<GetSearchResult>().data!.value.length,
      itemBuilder: (context, index) {
        var result = context.watch<GetSearchResult>().data!.value[index];
        return ListTile(
          title: Text(result.transporterName),
          subtitle: Text(result.transporterId),
        );
      },
    );
  }
}
