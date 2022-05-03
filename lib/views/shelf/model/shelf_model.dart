import 'dart:convert';

import 'package:books_finder/books_finder.dart' as bf;
import 'package:equatable/equatable.dart';

class ShelfModel extends Equatable {
  final String name;
  final List<bf.Book> books;

  const ShelfModel({
    required this.name,
    required this.books,
  });

  @override
  List<Object> get props => [name, books];

  ShelfModel copyWith({
    String? name,
    List<bf.Book>? books,
  }) {
    return ShelfModel(
      name: name ?? this.name,
      books: books ?? this.books,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'books': books,
    };
  }

  factory ShelfModel.fromMap(Map<String, dynamic> map) {
    return ShelfModel(
      name: map['name'] ?? '',
      books: List<bf.Book>.from(map['books'] ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelfModel.fromJson(String source) =>
      ShelfModel.fromMap(json.decode(source));

  @override
  String toString() => 'ShelfModel(name: $name, books: $books)';
}
