import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/app/bloc/app_bloc.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/settings/cubit/settings_cubit.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final user = context.select((AppBloc bloc) => bloc.state.user);

        return SafeArea(
          child: InkWell(
            onTap: () => context.read<SettingsCubit>().toggleSearchBar(true),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: state.isSearchBarOpened
                  ? EdgeInsets.zero
                  : EdgeInsets.all(10.w),
              height: state.isSearchBarOpened ? context.screenHeight : 46.0,
              decoration: BoxDecoration(
                borderRadius: state.isSearchBarOpened
                    ? BorderRadius.zero
                    : BorderRadius.circular(50.r),
                color: state.isDarkMode
                    ? Theme.of(context).primaryColor
                    : const Color(0xffECE2E3),
              ),
              child: !state.isSearchBarOpened
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: state.isSearchBarOpened
                            ? BorderRadius.zero
                            : BorderRadius.circular(50.r),
                        color: state.isDarkMode
                            ? Theme.of(context).primaryColor
                            : const Color(0xffECE2E3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const HSpace(10),
                              Icon(CupertinoIcons.search, size: 18.w),
                              const Text("Search Books").pOnly(left: 5.w),
                            ],
                          ),
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              user.photo ??
                                  'https://picsum.photos/seed/picsum/200/300',
                            ),
                            radius: 16.r,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      width: context.screenWidth,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 45.0,
                            width: context.screenWidth,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(CupertinoIcons.arrow_left),
                                  onPressed: () {
                                    context
                                        .read<SettingsCubit>()
                                        .toggleSearchBar(false);
                                    context.read<SearchCubit>().clearSearch();
                                  },
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CupertinoSearchTextField(
                                    onChanged: (query) {
                                      if (query.isNotEmpty) {
                                        context
                                            .read<SearchCubit>()
                                            .onSearchChanged(query);
                                      } else {
                                        context
                                            .read<SearchCubit>()
                                            .clearSearch();
                                      }
                                    },
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(CupertinoIcons.clear),
                                  onPressed: () =>
                                      context.read<SearchCubit>().clearSearch(),
                                ),
                              ],
                            ),
                          ),
                          BlocBuilder<SearchCubit, SearchState>(
                            builder: (context, state) {
                              return state.isLoading
                                  ? const SizedBox()
                                  : Column(
                                      children: List.generate(
                                        state.books.length,
                                        (index) {
                                          final book = state.books[index];

                                          return ListTile(
                                            leading: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20.0),
                                              child: book.info.imageLinks.values
                                                      .toList()
                                                      .isNotEmpty
                                                  ? SizedBox(
                                                      height: 64.0,
                                                      width: 36.0,
                                                      child: Image.network(
                                                        book.info.imageLinks
                                                            .values
                                                            .toList()[0]
                                                            .toString(),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    )
                                                  : const SizedBox(
                                                      height: 64.0,
                                                      width: 36.0,
                                                      child: FlutterLogo(
                                                          size: 64.0),
                                                    ),
                                            ),
                                            title: Text(book.info.title),
                                            subtitle: Text(
                                                book.info.authors.join(',')),
                                            // onTap: () => context.read<HomeCubit>().onBookSelected(book),
                                          );
                                        },
                                      ),
                                    );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );

        return SafeArea(
          child: FloatingSearchBar(
            hint: 'Search Books',
            scrollPadding: EdgeInsets.zero,
            // transitionDuration: const Duration(milliseconds: 300),
            // transitionCurve: Curves.easeInOut,
            // physics: const BouncingScrollPhysics(),
            scrollController: scrollController,
            elevation: 0.0,
            autocorrect: false,
            backgroundColor: state.isDarkMode
                ? Theme.of(context).primaryColor
                : const Color(0xffECE2E3),
            borderRadius: BorderRadius.circular(25.r),
            debounceDelay: const Duration(milliseconds: 300),
            onQueryChanged: (query) {
              if (query.isNotEmpty) {
                context.read<SearchCubit>().onSearchChanged(query);
              } else {
                context.read<SearchCubit>().clearSearch();
              }
            },
            transition: ExpandingFloatingSearchBarTransition(),
            leadingActions: [
              FloatingSearchBarAction.back(),
            ],
            actions: [
              FloatingSearchBarAction(
                showIfOpened: false,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    user.photo ?? 'https://picsum.photos/seed/picsum/200/300',
                  ),
                  radius: 16.r,
                ),
              ),
              FloatingSearchBarAction.searchToClear(
                showIfClosed: false,
              ),
            ],
            builder: (context, transition) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Material(
                  // elevation: 4.0,
                  color: Colors.transparent,
                  child: BlocBuilder<SearchCubit, SearchState>(
                    builder: (context, state) {
                      return state.isLoading
                          ? const SizedBox(
                              height: 100,
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Column(
                              children: List.generate(
                                state.books.length,
                                (index) {
                                  final book = state.books[index];

                                  return ListTile(
                                    leading: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: book.info.imageLinks.values
                                              .toList()
                                              .isNotEmpty
                                          ? SizedBox(
                                              height: 64.0,
                                              width: 36.0,
                                              child: Image.network(
                                                book.info.imageLinks.values
                                                    .toList()[0]
                                                    .toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : const SizedBox(
                                              height: 64.0,
                                              width: 36.0,
                                              child: FlutterLogo(size: 64.0),
                                            ),
                                    ),
                                    title: Text(book.info.title),
                                    subtitle: Text(book.info.authors.join(',')),
                                    // onTap: () => context.read<HomeCubit>().onBookSelected(book),
                                  );
                                },
                              ),
                            );
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
