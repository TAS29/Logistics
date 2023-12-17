part of 'search_result_bloc.dart';

@immutable
sealed class SearchResultState {
  const SearchResultState();
}

class SearchResultInitial extends SearchResultState {}

class SearchResultLoading extends SearchResultState {}

class SearchResultSuccess extends SearchResultState {
  final SearchModel data;

  const SearchResultSuccess(this.data);
}

class SearchResultError extends SearchResultState {
  final String errorMessage;

  const SearchResultError(this.errorMessage);
}
