import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:get/get.dart';
import 'package:givbooks/widgets/widgets.dart';
import 'package:velocity_x/velocity_x.dart';

import 'authentication.dart';
import 'components/custom_text_field.dart';
import 'components/forgot_password_dialog.dart';
import 'components/google_button.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  void _onForgetPasswordPressed(BuildContext context) {
    final _emailController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => PassResetMailDialog(
        emailController: _emailController,
        onPressed: () {
          // Fluttertoast.showToast(msg: 'TODO: Will be added soon');
          // if (!_formKey.currentState.validate()) return;

          // BlocProvider.of<AuthenticationBloc>(context).add(ForgetPassword(email: _emailController.text));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: ListView(
        children: [
          SizedBox(height: 50.w),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                'Welcome'.text.headline1(context).size(38.w).light.make(),
                SizedBox(height: 33.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _EmailInput(),
                    VSpace(22.w),
                    _PasswordInput(),
                    VSpace(12.w),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => _onForgetPasswordPressed(context),
                          child:
                              'Forgot Password?'.text.caption(context).make(),
                        ),
                      ],
                    ),
                    VSpace(12.w),
                    _LoginButton(),
                  ],
                ),
                VSpace(20.w),
                'or connect with'
                    .text
                    .headline4(context)
                    .size(13.w)
                    .make()
                    .centered(),
                VSpace(10.w),
                Hero(
                  tag: 'google-button',
                  child: GoogleButton(
                    title: "Continue with Google",
                    onPressed: () =>
                        context.read<LoginCubit>().logInWithGoogle(),
                  ),
                ),
                VSpace(100.w),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).push<void>(SignUpPage.route()),
                  child: 'Create a new account.'
                      .text
                      .caption(context)
                      .size(14.w)
                      .semiBold
                      .make(),
                ).centered(),
                // SizedBox(height: screenHeight * 0.045), //30
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return CustomTextField(
          key: const Key('loginForm_emailInput_textField'),
          // currentNode: _emailNode,
          // nextNode: _passwordNode,
          textInputAction: TextInputAction.next,
          maxLines: 1,
          // fieldController: _emailTextController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
          // validator: _validator.validateEmail,
          prefixIcon: const Icon(Icons.email_outlined),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Obx(() => CustomTextField(
              key: const Key('loginForm_passwordInput_textField'),
              // currentNode: _passwordNode,
              textInputAction: TextInputAction.done,
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              maxLines: 1,
              hintText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              keyboardType: TextInputType.text,
              obscureText: _isObscure.value,
              suffix: _isObscure.value
                  ? GestureDetector(
                      onTap: () => _isObscure.toggle(),
                      child: const Icon(Icons.visibility_off_outlined),
                    )
                  : GestureDetector(
                      onTap: () => _isObscure.toggle(),
                      child: const Icon(Icons.visibility_outlined),
                    ),
            ));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? BlueButton(
                title: "loading",
                onPressed: () {},
                isLoading: true,
              )
            : BlueButton(
                key: const Key('loginForm_continue_raisedButton'),
                title: "Sign In",
                onPressed: () =>
                    context.read<LoginCubit>().logInWithCredentials(),
              );
      },
    );
  }
}
