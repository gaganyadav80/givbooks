// // ignore_for_file: non_constant_identifier_names

// import 'dart:convert';

// import 'package:flutter/foundation.dart';

// class Book {
//   /// The id of the book
//   final String key;

//   final List<String>? seed;
//   final String? title;
//   final int? edition_count;
//   final List<String>? edition_key;
//   final int? first_publish_year;
//   final int? number_of_pages_median;
//   final List<String>? isbn;
//   final String? cover_edition_key;
//   final int? cover_i;
//   final List<String>? author_name;
//   final List<String>? subject;

//   final List<String>? id_amazon;
//   final List<String>? id_goodreads;
//   final List<String>? id_google;
//   final List<String>? id_overdrive;
//   Book({
//     required this.key,
//     this.seed,
//     this.title,
//     this.edition_count,
//     this.edition_key,
//     this.first_publish_year,
//     this.number_of_pages_median,
//     this.isbn,
//     this.cover_edition_key,
//     this.cover_i,
//     this.author_name,
//     this.subject,
//     this.id_amazon,
//     this.id_goodreads,
//     this.id_google,
//     this.id_overdrive,
//   });

//   /// The informations about best resulted book
//   // final BookInfo info;

//   Map<String, dynamic> toMap() {
//     return {
//       'key': key,
//       'seed': seed,
//       'title': title,
//       'edition_count': edition_count,
//       'edition_key': edition_key,
//       'first_publish_year': first_publish_year,
//       'number_of_pages_median': number_of_pages_median,
//       'isbn': isbn,
//       'cover_edition_key': cover_edition_key,
//       'cover_i': cover_i,
//       'author_name': author_name,
//       'subject': subject,
//       'id_amazon': id_amazon,
//       'id_goodreads': id_goodreads,
//       'id_google': id_google,
//       'id_overdrive': id_overdrive,
//     };
//   }

//   factory Book.fromMap(Map<String, dynamic> map) {
//     return Book(
//       key: map['key'] ?? '',
//       seed: List<String>.from(map['seed'] ?? []),
//       title: map['title'] ?? '',
//       edition_count: map['edition_count']?.toInt() ?? 0,
//       edition_key: List<String>.from(map['edition_key'] ?? []),
//       first_publish_year: map['first_publish_year']?.toInt() ?? 0,
//       number_of_pages_median: map['number_of_pages_median']?.toInt() ?? 0,
//       isbn: List<String>.from(map['isbn'] ?? []),
//       cover_edition_key: map['cover_edition_key'] ?? '',
//       cover_i: map['cover_i']?.toInt() ?? 0,
//       author_name: List<String>.from(map['author_name'] ?? []),
//       subject: List<String>.from(map['subject'] ?? []),
//       id_amazon: List<String>.from(map['id_amazon'] ?? []),
//       id_goodreads: List<String>.from(map['id_goodreads'] ?? []),
//       id_google: List<String>.from(map['id_google'] ?? []),
//       id_overdrive: List<String>.from(map['id_overdrive'] ?? []),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Book.fromJson(String source) => Book.fromMap(json.decode(source));

//   @override
//   String toString() {
//     return 'Book(key: $key, seed: $seed, title: $title, edition_count: $edition_count, edition_key: $edition_key, first_publish_year: $first_publish_year, number_of_pages_median: $number_of_pages_median, isbn: $isbn, cover_edition_key: $cover_edition_key, cover_i: $cover_i, author_name: $author_name, subject: $subject, id_amazon: $id_amazon, id_goodreads: $id_goodreads, id_google: $id_google, id_overdrive: $id_overdrive)';
//   }

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Book &&
//         other.key == key &&
//         listEquals(other.seed, seed) &&
//         other.title == title &&
//         other.edition_count == edition_count &&
//         listEquals(other.edition_key, edition_key) &&
//         other.first_publish_year == first_publish_year &&
//         other.number_of_pages_median == number_of_pages_median &&
//         listEquals(other.isbn, isbn) &&
//         other.cover_edition_key == cover_edition_key &&
//         other.cover_i == cover_i &&
//         listEquals(other.author_name, author_name) &&
//         listEquals(other.subject, subject) &&
//         listEquals(other.id_amazon, id_amazon) &&
//         listEquals(other.id_goodreads, id_goodreads) &&
//         listEquals(other.id_google, id_google) &&
//         listEquals(other.id_overdrive, id_overdrive);
//   }

//   @override
//   int get hashCode {
//     return key.hashCode ^
//         seed.hashCode ^
//         title.hashCode ^
//         edition_count.hashCode ^
//         edition_key.hashCode ^
//         first_publish_year.hashCode ^
//         number_of_pages_median.hashCode ^
//         isbn.hashCode ^
//         cover_edition_key.hashCode ^
//         cover_i.hashCode ^
//         author_name.hashCode ^
//         subject.hashCode ^
//         id_amazon.hashCode ^
//         id_goodreads.hashCode ^
//         id_google.hashCode ^
//         id_overdrive.hashCode;
//   }
// }
