import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givbooks/views/home/cubit/home_cubit.dart';
import 'package:givbooks/views/search/cubit/search_cubit.dart';
import 'package:givbooks/views/search/search_page.dart';
import 'package:givbooks/views/settings/cubit/settings_cubit.dart';
import 'package:givbooks/views/settings/settings_page.dart';
import 'package:givbooks/views/shelf/cubit/shelf_cubit.dart';
import 'package:givbooks/views/shelf/shelf_page.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (_) => HomeCubit(),
        ),
        BlocProvider<SearchCubit>(
          create: (_) => SearchCubit(),
        ),
        BlocProvider<ShelfCubit>(
          create: (_) => ShelfCubit(),
        ),
      ],
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.selectedIndex != current.selectedIndex,
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 70),
                  child: <Widget>[
                    const ShelfPage(),
                    // const SearchPage(),
                    const SettingsPage(),
                  ][state.selectedIndex],
                ),
                const SearchPage(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (int index) =>
                  context.read<HomeCubit>().selectedIndexChanged(index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.book), label: 'Shelf'),
                // NavigationDestination(
                //     icon: Icon(Icons.search), label: 'Search'),
                NavigationDestination(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            ),
          );
        },
      ),
    );
  }
}
