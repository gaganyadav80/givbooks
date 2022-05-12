import 'dart:convert';

import 'package:givbooks/views/shelf/model/shelf_model.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:equatable/equatable.dart';

part 'shelf_state.dart';

class ShelfCubit extends HydratedCubit<ShelfState> {
  ShelfCubit() : super(const ShelfState());

  void addDefaultShelf() {
    var shelves = const [
      ShelfModel(name: 'Read', books: []),
      ShelfModel(name: 'Currently Reading', books: []),
      ShelfModel(name: 'Want to Read', books: []),
    ];
    emit(state.copyWith(shelves: shelves));
  }

  void addShelf(String name) {
    List<ShelfModel> shelves = List<ShelfModel>.from(state.shelves);
    shelves.add(ShelfModel(name: name, books: const []));
    emit(state.copyWith(shelves: shelves));
  }

  void deleteShelf(ShelfModel model) {
    List<ShelfModel> shelves = List<ShelfModel>.from(state.shelves);
    shelves.remove(model);
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
