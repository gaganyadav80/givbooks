part of 'shelf_cubit.dart';

class ShelfState extends Equatable {
  const ShelfState({this.shelves = const []});

  final List<ShelfModel> shelves;

  @override
  List<Object> get props => [shelves];

  ShelfState copyWith({List<ShelfModel>? shelves}) {
    return ShelfState(shelves: shelves ?? this.shelves);
  }
}
