part of 'search_result_bloc.dart';

@immutable
sealed class SearchResultEvent {
  const SearchResultEvent();
}

class GetSearchResultEvent extends SearchResultEvent {
  final String searchedText;

  const GetSearchResultEvent(this.searchedText);
}

