import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:givbooks/views/home/cubit/home_cubit.dart';
import 'package:givbooks/views/search/search_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    // final user = context.select((AppBloc bloc) => bloc.state.user);
    // context.read<AppBloc>().add(AppLogoutRequested())

    return BlocProvider(
      create: (_) => HomeCubit(),
      child: BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous.selectedIndex != current.selectedIndex,
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state.appBarTitle.text.white.make(),
              titleTextStyle: GoogleFonts.montserrat(fontSize: 28),
            ),
            body: <Widget>[
              'Shelf'.text.make().centered(),
              const SearchPage(),
              'Settings'.text.make().centered(),
            ][state.selectedIndex],
            bottomNavigationBar: NavigationBar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
              selectedIndex: state.selectedIndex,
              onDestinationSelected: (int index) =>
                  context.read<HomeCubit>().selectedIndexChanged(index),
              destinations: const [
                NavigationDestination(icon: Icon(Icons.book), label: 'Shelf'),
                NavigationDestination(
                    icon: Icon(Icons.search), label: 'Search'),
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
