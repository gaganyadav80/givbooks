import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void selectedIndexChanged(int index) {
    emit(state.copyWith(
      selectedIndex: index,
    ));
  }
}

class HomeState extends Equatable {
  const HomeState({this.selectedIndex = 0});

  final int selectedIndex;

  @override
  List<Object> get props => [selectedIndex];

  HomeState copyWith({int? selectedIndex}) {
    return HomeState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
