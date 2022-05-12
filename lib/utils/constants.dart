import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum FormzStatus {
  pure, // FormzInput is empty
  invalid,
  valid,
  submissionCanceled,
  submissionInProgress,
  submissionSuccess,
  submissionFailure,
}

final kBorderRadius = BorderRadius.circular(1.r);

final kInputBorderStyle = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: const BorderSide(
    width: 1.0,
    // color: Colors.grey[400]!,
    color: Colors.black54,
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
