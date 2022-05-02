import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:books_finder/books_finder.dart' as bf;

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  void onSearchChanged(String query) async {
    emit(state.copyWith(isLoading: true));

    final List<bf.Book> books = await bf.queryBooks(
      query,
      maxResults: 20,
      printType: bf.PrintType.books,
      orderBy: bf.OrderBy.relevance,
      reschemeImageLinks: true,
    );
    emit(state.copyWith(query: query, books: books, isLoading: false));
  }

  void clearSearch() {
    emit(state.copyWith(query: '', books: <bf.Book>[]));
  }
}
