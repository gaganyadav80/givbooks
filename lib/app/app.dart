import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:givbooks/views/settings/cubit/settings_cubit.dart';

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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            create: (_) =>
                AppBloc(authenticationRepository: _authenticationRepository),
          ),
          BlocProvider<SettingsCubit>(create: (_) => SettingsCubit())
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final savedThemeMode = await AdaptiveTheme.getThemeMode();

    return AdaptiveTheme(
      light: FlexThemeData.light(
        transparentStatusBar: false,
        scheme: FlexScheme.blue,
        // subThemesData: const FlexSubThemesData(),
        scaffoldBackground: const Color(0xffF2F2F6),
        useMaterial3: false,
        useMaterial3ErrorColors: true,
      ),
      dark: FlexThemeData.dark(
        transparentStatusBar: false,
        scheme: FlexScheme.blue,
        // subThemesData: const FlexSubThemesData(),
        useMaterial3: false,
        useMaterial3ErrorColors: true,
      ),
      initial: context.read<SettingsCubit>().state.isDarkMode
          ? AdaptiveThemeMode.dark
          : AdaptiveThemeMode.light,
      builder: (light, dark) {
        return GetMaterialApp(
          title: 'Giv Books',
          debugShowCheckedModeBanner: false,
          builder: (BuildContext context, Widget? widget) {
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
            return widget!;
          },
          theme: light,
          darkTheme: dark,
          // Use dark or light theme based on system setting.
          // themeMode: ThemeMode.light,
          home: const LoginFlow(),
        );
      },
    );
  }
}

class LoginFlow extends StatelessWidget {
  const LoginFlow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AppStatus>(
      state: context.select((AppBloc bloc) => bloc.state.status),
      onGeneratePages: onGenerateAppViewPages,
    );
  }
}
