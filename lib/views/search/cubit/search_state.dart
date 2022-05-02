part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({
    this.query = '',
    this.isLoading = false,
    this.books = const <bf.Book>[],
  });

  final String query;
  final List<bf.Book> books;
  final bool isLoading;

  @override
  List<Object> get props => [query, books, isLoading];

  SearchState copyWith({
    String? query,
    List<bf.Book>? books,
    bool? isLoading,
  }) {
    return SearchState(
      query: query ?? this.query,
      books: books ?? this.books,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
