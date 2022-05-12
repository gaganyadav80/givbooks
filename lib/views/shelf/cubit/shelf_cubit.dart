import 'dart:convert';
import 'dart:developer';

import 'package:givbooks/views/shelf/model/shelf_model.dart';
import 'package:books_finder/books_finder.dart' as bf;
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'shelf_state.dart';

class ShelfCubit extends HydratedCubit<ShelfState> {
  ShelfCubit() : super(const ShelfState());

  void addDefaultShelf() {
    var shelves = [
      ShelfModel(id: const Uuid().v1(), name: 'Read', books: const []),
      ShelfModel(id: const Uuid().v1(), name: 'Currently Reading', books: const []),
      ShelfModel(id: const Uuid().v1(), name: 'Want to Read', books: const []),
    ];
    emit(state.copyWith(shelves: shelves));
  }

  void addShelf(String name) {
    List<ShelfModel> shelves = List<ShelfModel>.from(state.shelves);
    shelves.add(ShelfModel(id: const Uuid().v1(), name: name, books: const []));
    emit(state.copyWith(shelves: shelves));
  }

  void deleteShelf(ShelfModel model) {
    List<ShelfModel> shelves = List<ShelfModel>.from(state.shelves);
    shelves.remove(model);
    emit(state.copyWith(shelves: shelves));
  }

  void addBookToShelf(int index, bf.Book book) {
    List<ShelfModel> shelves = List<ShelfModel>.from(state.shelves);
    List<bf.Book> books = List<bf.Book>.from(shelves[index].books);
    books.add(book);
    shelves[index].books = books;
    emit(state.copyWith(shelves: shelves));
  }

  @override
  ShelfState? fromJson(Map<String, dynamic> json) {
    return ShelfState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ShelfState state) {
    return state.toMap();
  }
}
