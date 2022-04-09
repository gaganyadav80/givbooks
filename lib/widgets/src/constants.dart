import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final kBorderRadius = BorderRadius.circular(12.r);

final kInputBorderStyle = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: BorderSide(
    width: 1.0,
    color: Colors.grey[500]!.withOpacity(0.5),
  ),
);

class VSpace extends StatelessWidget {
  const VSpace(this.height, {Key? key}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: height);
  }
}

class HSpace extends StatelessWidget {
  const HSpace(this.width, {Key? key}) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: width);
  }
}
