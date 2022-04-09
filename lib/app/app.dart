import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'bloc/app_bloc.dart';
import 'routes.dart';

import 'package:authentication_repository/authentication_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Giv Books',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        scheme: FlexScheme.mandyRed,
        subThemesData: const FlexSubThemesData(),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ),
      // The Mandy red, dark theme.
      darkTheme: FlexThemeData.dark(
        scheme: FlexScheme.rosewood,
        subThemesData: const FlexSubThemesData(),
        useMaterial3: true,
        useMaterial3ErrorColors: true,
      ),
      // Use dark or light theme based on system setting.
      themeMode: ThemeMode.light,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
