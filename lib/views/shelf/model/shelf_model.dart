import 'dart:convert';

import 'package:books_finder/books_finder.dart' as bf;
import 'package:equatable/equatable.dart';

class ShelfModel extends Equatable {
  final String? id;
  final String name;
  List<bf.Book> books;

  ShelfModel({
    this.id,
    required this.name,
    required this.books,
  });

  @override
  List<Object> get props => [id!, name, books];

  ShelfModel copyWith({
    String? name,
    List<bf.Book>? books,
  }) {
    return ShelfModel(
      id: id,
      name: name ?? this.name,
      books: books ?? this.books,
    );
  }

  @override
  String toString() => 'ShelfModel(id: $id, name: $name, books: $books)';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'books': books.map((x) => x.toJson()).toList(),
    };
  }

  factory ShelfModel.fromMap(Map<String, dynamic> map) {
    return ShelfModel(
      id: map['id'],
      name: map['name'] ?? '',
      books: List<bf.Book>.from(map['books']?.map((x) => bf.Book.fromJson(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelfModel.fromJson(String source) => ShelfModel.fromMap(json.decode(source));
}
