import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:givbooks/utils/utils.dart';
import 'package:givbooks/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'authentication.dart';
import 'components/custom_text_field.dart';
import 'components/google_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pop();
        } else if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.errorMessage ?? 'Sign Up Failure')),
            );
        }
      },
      child: ListView(
        children: [
          // SizedBox(height: 50.w),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Sign Up'.text.headline1(context).size(38.w).light.make(),
                SizedBox(height: 33.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _NameInput(),
                    SizedBox(height: 22.w),
                    _EmailInput(),
                    SizedBox(height: 22.w),
                    _PasswordInput(),
                    SizedBox(height: 22.w),
                    _ConfirmPasswordInput(),
                    SizedBox(height: 22.w),
                    Visibility(
                      visible: false,
                      child:
                          '* Please store your password safely because it acts as your '
                              .richText
                              .xs
                              .color(CupertinoColors.destructiveRed)
                              .light
                              .withTextSpanChildren(<TextSpan>[
                        'MASTER KEY. '.textSpan.medium.italic.make(),
                        'We won\'t be able to reset it for you.'
                            .textSpan
                            .light
                            .make(),
                      ]).make(),
                    ),
                    SizedBox(height: 22.w),
                    _SignUpButton(),
                  ],
                ),
                SizedBox(height: 25.w),
                'or register with'
                    .text
                    .headline4(context)
                    .size(12.w)
                    .make()
                    .centered(),
                SizedBox(height: 10.w),
                Hero(
                  tag: 'google-button',
                  child: GoogleButton(
                    title: "Continue with Google",
                    onPressed: () =>
                        context.read<LoginCubit>().logInWithGoogle(),
                  ),
                ),
                SizedBox(height: 30.w),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return CustomTextField(
          onChanged: (name) => context.read<SignUpCubit>().nameChanged(name),
          textInputAction: TextInputAction.next,
          maxLines: 1,
          hintText: 'Name',
          prefixIcon: const Icon(Icons.person_outline_outlined),
          keyboardType: TextInputType.name,
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          // currentNode: _nameNode,
          // nextNode: _emailNode,
          onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
          textInputAction: TextInputAction.next,
          maxLines: 1,
          hintText: 'Email',
          prefixIcon: const Icon(Icons.mail_outline_rounded),
          keyboardType: TextInputType.name,
          errorText: state.status.isInvalid ? 'invalid email' : null,
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  final RxBool _isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          // currentNode: _passwordNode,
          // nextNode: _confirmPassNode,
          key: const Key('signUpForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<SignUpCubit>().passwordChanged(password),
          textInputAction: TextInputAction.done,
          maxLines: 1,
          hintText: 'Password',
          prefixIcon: const Icon(Icons.lock_outline),
          keyboardType: TextInputType.text,
          obscureText: _isObscure.value,
          suffix: _isObscure.value
              ? GestureDetector(
                  onTap: () => _isObscure.toggle(),
                  child: const Icon(Icons.visibility_off_outlined))
              : GestureDetector(
                  onTap: () => _isObscure.toggle(),
                  child: const Icon(Icons.visibility_outlined)),
          errorText: state.status.isInvalid ? 'password is too short' : null,
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  final RxBool _isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return CustomTextField(
          // currentNode: _passwordNode,
          // nextNode: _confirmPassNode,
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          onChanged: (confirmPassword) => context
              .read<SignUpCubit>()
              .confirmedPasswordChanged(confirmPassword),
          textInputAction: TextInputAction.done,
          maxLines: 1,
          hintText: 'Confirm Password',
          prefixIcon: const Icon(Icons.lock_outline),
          keyboardType: TextInputType.text,
          obscureText: _isObscure.value,
          suffix: _isObscure.value
              ? GestureDetector(
                  onTap: () => _isObscure.toggle(),
                  child: const Icon(Icons.visibility_off_outlined))
              : GestureDetector(
                  onTap: () => _isObscure.toggle(),
                  child: const Icon(Icons.visibility_outlined)),
          errorText: state.status.isInvalid ? 'passwords do not match' : null,
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? BlueButton(
                title: "loading",
                onPressed: () {},
                isLoading: true,
              )
            : BlueButton(
                key: const Key('signUpForm_continue_raisedButton'),
                title: "Sign Up",
                onPressed: () =>
                    context.read<SignUpCubit>().signUpFormSubmitted(),
              );
      },
    );
  }
}
