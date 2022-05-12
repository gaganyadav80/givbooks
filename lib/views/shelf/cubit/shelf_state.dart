part of 'shelf_cubit.dart';

class ShelfState extends Equatable {
  const ShelfState({this.shelves = const []});

  final List<ShelfModel> shelves;

  @override
  List<Object> get props => [shelves];

  ShelfState copyWith({List<ShelfModel>? shelves}) {
    return ShelfState(shelves: shelves ?? this.shelves);
  }

  Map<String, dynamic> toMap() {
    return {
      'shelves': shelves.map((x) => x.toMap()).toList(),
    };
  }

  factory ShelfState.fromMap(Map<String, dynamic> map) {
    return ShelfState(
      shelves: List<ShelfModel>.from(
          map['shelves']?.map((x) => ShelfModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ShelfState.fromJson(String source) =>
      ShelfState.fromMap(json.decode(source));
}
