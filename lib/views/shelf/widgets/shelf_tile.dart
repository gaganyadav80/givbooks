import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/shelf/cubit/shelf_cubit.dart';
import 'package:givbooks/views/shelf/model/shelf_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ShelfTile extends StatelessWidget {
  const ShelfTile(this.model, this.rootCtx, {Key? key}) : super(key: key);

  final ShelfModel model;
  final BuildContext rootCtx;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Delete Shelf"),
            content: const Text("Are you sure you want to delete this shelf?"),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: const Text("Delete"),
                onPressed: () {
                  rootCtx.read<ShelfCubit>().deleteShelf(model);
                  VxToast.show(context, msg: "Shelf deleted");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.w),
        child: Row(
          children: [
            SizedBox(
              height: 70,
              width: 70,
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40),
                    height: 50,
                    width: 30,
                    color: Colors.grey[400],
                    child: model.books.length > 2
                        ? Image.network(model.books[2].info.imageLinks.values
                            .toList()[0]
                            .toString())
                        : Container(),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 60,
                    width: 40,
                    color: Colors.grey[350],
                    child: model.books.length > 1
                        ? Image.network(model.books[1].info.imageLinks.values
                            .toList()[0]
                            .toString())
                        : Container(),
                  ),
                  Container(
                    height: 70,
                    width: 50,
                    color: Colors.grey[300],
                    child: model.books.isNotEmpty
                        ? Image.network(model.books.first.info.imageLinks.values
                            .toList()[0]
                            .toString())
                        : Container(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    VSpace(10.w),
                    Text(
                      '${model.books.length} books',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
