import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/search/cubit/search_cubit.dart';
import 'package:books_finder/books_finder.dart' as bf;
import 'package:givbooks/views/shelf/cubit/shelf_cubit.dart';
import 'package:givbooks/views/shelf/widgets/shelf_tile.dart';
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
                                  VSpace(5.w),
                                  book.info.subtitle.text.color(Colors.grey).size(12.w).make(),
                                  "by ${book.info.authors.first}".text.make(),
                                  VSpace(10.w),
                                  book.info.categories.toString().text.color(Colors.grey).make(),
                                  VSpace(15.w),
                                  Row(
                                    children: [
                                      BorderTextButton(
                                        onPressed: () {},
                                        height: 40.w,
                                        width: 120.w,
                                        padding: EdgeInsets.zero,
                                        child: "Want to read".text.extraBlack.make(),
                                      ),
                                      HSpace(5.w),
                                      BorderTextButton(
                                        onPressed: () => showModalBottomSheet(
                                          context: context,
                                          builder: (context) => _ShowAddShelfModel(book),
                                        ),
                                        height: 40.w,
                                        width: 40.w,
                                        padding: EdgeInsets.zero,
                                        child: const Icon(LineIcons.caretDown),
                                      ),
                                    ],
                                  ),
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

class _ShowAddShelfModel extends StatelessWidget {
  const _ShowAddShelfModel(this.book, {Key? key}) : super(key: key);

  final bf.Book book;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfCubit, ShelfState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              state.shelves.length,
              (index) {
                return InkWell(
                  onTap: () => context.read<ShelfCubit>().addBookToShelf(index, book),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShelfTile(state.shelves[index]),
                      Padding(
                        padding: EdgeInsets.only(right: 20.w),
                        child: state.shelves[index].books.any((element) => element.id == book.id)
                            ? const Icon(LineIcons.check)
                            : const Icon(LineIcons.times),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
