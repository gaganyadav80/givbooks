import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:givbooks/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    Key? key,
    required this.hintText,
    required this.keyboardType,
    required this.prefixIcon,
    required this.textInputAction,
    required this.maxLines,
    required this.onChanged,
    this.errorText,
    this.currentNode,
    this.nextNode,
    this.obscureText,
    this.enabled,
    this.suffix,
    this.textCapitalization,
    this.inputFormatters,
    this.maxLength,
  }) : super(key: key);

  final String hintText;
  final TextInputType keyboardType;
  final bool? obscureText;
  final int maxLines;
  final bool? enabled;
  final Widget? suffix;
  final TextInputAction textInputAction;
  final FocusNode? currentNode;
  final FocusNode? nextNode;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization? textCapitalization;
  final Icon prefixIcon;
  final int? maxLength;
  final Function(String)? onChanged;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: key,
      focusNode: currentNode,
      onSubmitted: (value) {
        if (currentNode != null) {
          currentNode!.unfocus();
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onChanged: onChanged,
      textInputAction: textInputAction,
      enabled: enabled ?? true,
      maxLines: maxLines,
      maxLength: maxLength,
      maxLengthEnforcement:
          maxLength != null ? MaxLengthEnforcement.enforced : null,
      // controller: fieldController,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      // validator: validator,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      textAlignVertical: TextAlignVertical.center,
      style: Theme.of(context).textTheme.caption!.copyWith(
            fontSize: 14.w,
            fontWeight: FontWeight.w400,
          ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        suffixIcon: suffix,
        border: kInputBorderStyle,
        focusedBorder: kInputBorderStyle,
        enabledBorder: kInputBorderStyle,
        errorBorder: kInputBorderStyle.copyWith(
          borderSide: BorderSide(color: Theme.of(context).errorColor),
        ),
        focusedErrorBorder: kInputBorderStyle.copyWith(
          borderSide: BorderSide(color: Theme.of(context).errorColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 19.w),
        hintText: hintText,
        prefixIcon: prefixIcon,
        errorText: errorText,
      ),
    );
  }
}
