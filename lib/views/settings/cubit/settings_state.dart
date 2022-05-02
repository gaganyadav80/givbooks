part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.isSearchBarOpened = false,
  });

  final bool isDarkMode;
  final bool isSearchBarOpened;

  @override
  List<Object> get props => [isDarkMode, isSearchBarOpened];

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isSearchBarOpened,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSearchBarOpened: isSearchBarOpened ?? this.isSearchBarOpened,
    );
  }
}
