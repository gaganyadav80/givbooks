part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isDarkMode = false,
    this.isSearchBarOpened = false,
    this.showExpandedChild = false,
  });

  final bool isDarkMode;
  final bool isSearchBarOpened;
  final bool showExpandedChild;

  @override
  List<Object> get props => [isDarkMode, isSearchBarOpened, showExpandedChild];

  SettingsState copyWith({
    bool? isDarkMode,
    bool? isSearchBarOpened,
    bool? showExpandedChild,
  }) {
    return SettingsState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isSearchBarOpened: isSearchBarOpened ?? this.isSearchBarOpened,
      showExpandedChild: showExpandedChild ?? this.showExpandedChild,
    );
  }
}
