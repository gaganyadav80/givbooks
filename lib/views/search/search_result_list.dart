import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/search/cubit/search_cubit.dart';
import 'package:givbooks/widgets/widgets.dart';
import 'package:line_icons/line_icons.dart';
import 'package:velocity_x/velocity_x.dart';

class SearchResultList extends StatelessWidget {
  const SearchResultList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CircularLoading())
              : ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.books.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    final book = state.books[index];

                    return InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 155.w,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            book.info.imageLinks.values.toList().isNotEmpty
                                ? SizedBox(
                                    height: 154.w,
                                    width: 100.w,
                                    child: CachedNetworkImage(
                                      imageUrl: book.info.imageLinks.values.toList()[0].toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 154.w,
                                    width: 100.w,
                                    color: Colors.grey.withOpacity(0.5),
                                    child: const Center(child: Icon(CupertinoIcons.question)),
                                  ),
                            HSpace(20.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  book.info.title.text.color(Theme.of(context).primaryColor).size(16.w).make(),
                                  book.info.subtitle.text.color(Colors.grey).make(),
                                  book.info.categories.toString().text.make(),
                                  "by ${book.info.authors.first}".text.make(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
        },
      ),
    );
  }
}
