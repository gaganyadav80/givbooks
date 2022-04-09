import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:formz/formz.dart';
import 'package:velocity_x/velocity_x.dart';

import 'authentication.dart';
import 'components/google_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
      BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        maxHeight: MediaQuery.of(context).size.height,
      ),
      designSize: const Size(390, 844),
      context: context,
      minTextAdapt: true,
      orientation: Orientation.portrait,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // title: 'GivBooks'.text.make(),
        // iconTheme: const IconThemeData(color: Colors.black),
        // leading: ModalRoute.of(context)!.canPop
        //     ? InkWell(
        //         onTap: () => Navigator.pop(context),
        //         child: const Icon(Icons.close, color: Colors.black),
        //       )
        //     : null,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.w),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status.isSubmissionFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content:
                          Text(state.errorMessage ?? 'Authentication Failure'),
                    ),
                  );
              }
            },
            child: const LoginForm(),
          ),
        ),
      ),
    );
  }
}
