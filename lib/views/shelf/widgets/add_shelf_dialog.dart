import 'package:flutter/material.dart';
import 'package:givbooks/views/shelf/shelf_controller.dart';
import 'package:velocity_x/velocity_x.dart';

class AddShelfDialog extends StatelessWidget {
  AddShelfDialog(this.rootCtx, {Key? key}) : super(key: key);

  final BuildContext rootCtx;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Enter Shelf Name"),
      content: TextField(controller: _controller),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text("Add"),
          onPressed: () {
            if (_controller.text.isEmpty) {
              VxToast.show(context, msg: "Please enter shelf name");
              return;
            }
            ShelfController.to.addShelf(_controller.text);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
