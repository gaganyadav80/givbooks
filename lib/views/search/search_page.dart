import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/views/settings/cubit/settings_cubit.dart';
import 'package:givbooks/widgets/widgets.dart';

import 'cubit/search_cubit.dart';
import 'search_result_list.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        context.read<SearchCubit>().clearSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 10),
          CupertinoSearchTextField(
            controller: _controller,
            borderRadius: BorderRadius.circular(1.r),
            prefixIcon: const Padding(
              padding: EdgeInsets.fromLTRB(2, 4, 4, 0),
              child: Icon(CupertinoIcons.search),
            ),
            style: context.read<SettingsCubit>().state.isDarkMode
                ? const TextStyle(color: CupertinoColors.white)
                : const TextStyle(color: CupertinoColors.secondaryLabel),
            onSuffixTap: () {
              _controller.clear();
              context.read<SearchCubit>().clearSearch();
            },
            onSubmitted: (query) {
              if (query.isNotEmpty) {
                context.read<SearchCubit>().onSearchChanged(query);
              }
            },
          ),
          const SizedBox(height: 20),
          const SearchResultList(),
        ],
      ),
    );
  }
}
