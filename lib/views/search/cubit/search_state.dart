part of 'search_cubit.dart';

class SearchState extends Equatable {
  const SearchState({this.books = const <OLBook>[]});

  final List<OLBook> books;

  @override
  List<Object> get props => [books];

  SearchState copyWith({List<OLBook>? books}) {
    return SearchState(books: books ?? this.books);
  }
}
