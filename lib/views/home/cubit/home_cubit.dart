import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  final List<String> _destinations = [
    'Shelf',
    'Search',
    'Settings',
  ];

  void selectedIndexChanged(int index) {
    emit(state.copyWith(
      selectedIndex: index,
      appBarTitle: _destinations[index],
    ));
  }
}

class HomeState extends Equatable {
  const HomeState({
    this.selectedIndex = 0,
    this.appBarTitle = 'Shelf',
  });

  final int selectedIndex;
  final String appBarTitle;

  @override
  List<Object> get props => [selectedIndex, appBarTitle];

  HomeState copyWith({
    int? selectedIndex,
    String? appBarTitle,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      appBarTitle: appBarTitle ?? this.appBarTitle,
    );
  }
}
