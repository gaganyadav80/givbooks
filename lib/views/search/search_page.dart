import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/app/bloc/app_bloc.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/settings/cubit/settings_cubit.dart';
import 'package:velocity_x/velocity_x.dart';

import 'cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final user = context.select((AppBloc bloc) => bloc.state.user);

        return SafeArea(
          child: GestureDetector(
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
              child: !state.showExpandedChild
                  ? state.isSearchBarOpened
                      ? const SizedBox(width: double.infinity)
                      : Container(
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
                          const VSpace(10),
                          SizedBox(
                            height: 45.0,
                            width: context.screenWidth,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(CupertinoIcons.arrow_left),
                                  onPressed: () {
                                    context
                                        .read<SettingsCubit>()
                                        .toggleSearchBar(false);
                                    context.read<SearchCubit>().clearSearch();
                                  },
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: CupertinoTextField(
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
                                  icon: const Icon(CupertinoIcons.clear),
                                  onPressed: () =>
                                      context.read<SearchCubit>().clearSearch(),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: BlocBuilder<SearchCubit, SearchState>(
                              builder: (context, state) {
                                return state.isLoading
                                    ? const SizedBox()
                                    : ListView(
                                        children: List.generate(
                                          state.books.length,
                                          (index) {
                                            final book = state.books[index];

                                            return ListTile(
                                              leading: Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: book
                                                        .info.imageLinks.values
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
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
