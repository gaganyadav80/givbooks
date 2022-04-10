import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';

import 'cubit/search_cubit.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Column(
        children: [
          VSpace(20.w),
          BuildSearchTextField(),
          VSpace(20.w),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Expanded(
                child: ListView.builder(
                  itemCount: state.books.length,
                  itemBuilder: (context, index) {
                    final book = state.books[index];
                    return ListTile(
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: SizedBox(
                          height: book.covers.isNotEmpty ? 64.0 : 0,
                          child: book.covers.isNotEmpty
                              ? Image.memory(book.covers.first)
                              : null,
                        ),
                      ),
                      title: Text(book.title),
                      subtitle: Text(book.authors.join(", ")),
                      // onTap: () => context.read<HomeCubit>().onBookSelected(book),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BuildSearchTextField extends StatelessWidget {
  BuildSearchTextField({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      title: SizedBox(
        height: 50,
        child: TextField(
          controller: _controller,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Theme.of(context).primaryColor),
          onPressed: () => context
              .read<SearchCubit>()
              .onSearchChanged(_controller.text, context),
        ),
      ],
    );
  }
}
