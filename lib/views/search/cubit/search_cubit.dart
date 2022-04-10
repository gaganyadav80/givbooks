import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_library/models/ol_book_model.dart';
import 'package:open_library/models/ol_search_model.dart';
import 'package:open_library/open_library.dart';
import 'package:provider/provider.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(const SearchState());

  void onSearchChanged(String query, BuildContext context) async {
    final OLSearchBase search =
        await Provider.of<OpenLibrary>(context, listen: false)
            .query(q: query, limit: 10);

    List<OLBook> books = <OLBook>[];

    if (search is OLSearch) {
      books.clear();

      log("search:\n$search");

      for (var doc in search.docs) {
        final OLBook book = OLBook(
          title: doc.title,
          authors: doc.authors,
          covers: doc.covers,
        );
        books.add(book);
      }
    }

    emit(state.copyWith(books: books));
  }
}
