import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:givbooks/utils/utils.dart';

import 'custom_text_field.dart';

class PassResetMailDialog extends StatelessWidget {
  final VoidCallback onPressed;
  final TextEditingController emailController;

  PassResetMailDialog({
    Key? key,
    required this.onPressed,
    required this.emailController,
  }) : super(key: key);

  final RxBool _isValidEmail = true.obs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
      title: Text(
        "Forgot Password",
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontSize: 22.w,
              fontWeight: FontWeight.w300,
            ),
      ),
      content: SizedBox(
        width: 320.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VSpace(20.w),
            Obx(() => CustomTextField(
                // fieldController: emailController,
                hintText: "Enter registered email",
                prefixIcon: const Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                // validator: Validator().validateEmail,
                onChanged: (email) => _isValidEmail.value = email.isEmail,
                maxLines: 1,
                errorText: !_isValidEmail.value ? 'invalid email' : null)),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("CANCEL"),
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text("CONFIRM"),
        ),
      ],
    );
  }
}
