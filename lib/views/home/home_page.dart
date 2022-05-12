import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/views/home/cubit/home_cubit.dart';
import 'package:givbooks/views/search/cubit/search_cubit.dart';
import 'package:givbooks/views/search/search_page.dart';
import 'package:givbooks/views/settings/settings_page.dart';
import 'package:givbooks/views/shelf/cubit/shelf_cubit.dart';
import 'package:givbooks/views/shelf/shelf_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

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
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              titleTextStyle: GoogleFonts.roboto(
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
                fontSize: 30.w,
                fontWeight: FontWeight.bold,
              ),
              title: [
                const Text('Shelf'),
                const Text('Search'),
                const Text('Settings'),
              ][state.selectedIndex],
            ),
            resizeToAvoidBottomInset: false,
            body: <Widget>[
              const ShelfPage(),
              const SearchPage(),
              const SettingsPage(),
            ][state.selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.selectedIndex,
              selectedFontSize: 12.0,
              unselectedFontSize: 12.0,
              elevation: 2.0,
              onTap: (int index) =>
                  context.read<HomeCubit>().selectedIndexChanged(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.swatchbook),
                  label: 'Shelf',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.horizontalSliders),
                  label: 'Settings',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
