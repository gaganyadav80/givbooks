import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';

import 'cubit/shelf_cubit.dart';
import 'widgets/add_shelf_dialog.dart';
import 'widgets/shelf_tile.dart';

class ShelfPage extends StatelessWidget {
  const ShelfPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShelfCubit, ShelfState>(
      builder: (context, state) {
        return state.shelves.isEmpty
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
                  itemCount: state.shelves.length,
                  itemBuilder: (_, index) {
                    return ShelfTile(state.shelves[index], context);
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
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
                rootCtx.read<ShelfCubit>().addDefaultShelf();
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
