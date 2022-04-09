import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(MyApp(authenticationRepository: authenticationRepository));
    },
    blocObserver: AppBlocObserver(),
  );
}
