import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;

      final storage = await HydratedStorage.build(
          storageDirectory: await getTemporaryDirectory());
      HydratedBlocOverrides.runZoned(
        () => runApp(MyApp(authenticationRepository: authenticationRepository)),
        storage: storage,
      );
    },
    blocObserver: AppBlocObserver(),
  );
}
