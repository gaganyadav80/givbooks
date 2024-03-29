import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/views/shelf/shelf_controller.dart';

import 'widgets/add_shelf_dialog.dart';
import 'widgets/shelf_tile.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShelfController>(
      builder: (controller) {
        return controller.shelves.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('No shelves yet'),
                    VSpace(20.w),
                    ElevatedButton(
                      child: const Text('Add shelf'),
                      onPressed: () => showModalBottomSheet(
                        context: context,
                        builder: (_) => _ShelfModal(context),
                      ),
                    ),
                  ],
                ),
              )
            : Scaffold(
                body: ListView.builder(
                  itemCount: controller.shelves.length,
                  itemBuilder: (_, index) {
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
                                  controller.deleteShelf(controller.shelves[index]);
                                  VxToast.show(context, msg: "Shelf deleted");
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      child: ShelfTile(controller.shelves[index]),
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (_) => AddShelfDialog(context),
                  ),
                  child: const Icon(CupertinoIcons.add),
                ),
              );
      },
    );
  }
}

class _ShelfModal extends StatelessWidget {
  const _ShelfModal(this.rootCtx, {Key? key}) : super(key: key);

  final BuildContext rootCtx;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(1.r)),
      ),
      elevation: 0.0,
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.bookmark_fill),
              title: const Text('Add Default Shelf'),
              subtitle: const Text(
                'Adds Read, Currently Reading and Want to Read Shelves to your shelf',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              onTap: () {
                ShelfController.to.addDefaultShelf();
                Navigator.of(context).pop();
              },
            ),
            const VSpace(20.0),
            ListTile(
              leading: const Icon(CupertinoIcons.add_circled_solid),
              title: const Text('Add Manual Shelf'),
              subtitle: const Text(
                'Add a shelf manually by entering the name of the shelf',
                style: TextStyle(fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  builder: (_) => AddShelfDialog(rootCtx),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
