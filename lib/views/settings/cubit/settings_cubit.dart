import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'settings_state.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleDarkMode(bool value, BuildContext context) {
    if (value) {
      AdaptiveTheme.of(context).setDark();
    } else {
      AdaptiveTheme.of(context).setLight();
    }
    emit(state.copyWith(isDarkMode: value));
  }

  void toggleSearchBar(bool value) {
    emit(state.copyWith(isSearchBarOpened: value));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) {
    return SettingsState(
      isDarkMode: json['isDarkMode'] as bool,
      isSearchBarOpened: json['isSearchBarOpened'] as bool,
    );
  }

  @override
  Map<String, dynamic>? toJson(SettingsState state) {
    return <String, dynamic>{
      'isDarkMode': state.isDarkMode,
      'isSearchBarOpened': state.isSearchBarOpened,
    };
  }
}
