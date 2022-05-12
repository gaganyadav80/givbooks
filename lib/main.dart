import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:givbooks/views/shelf/shelf_controller.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/bloc_observer.dart';
import 'utils/db_helper.dart';

void main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;

      final storage = await HydratedStorage.build(storageDirectory: await getTemporaryDirectory());

      await GetStorage.init(DBHelper.DB_KEY);

      DBHelper.db = GetStorage(DBHelper.DB_KEY);

      initControllers();

      HydratedBlocOverrides.runZoned(
        () => runApp(MyApp(authenticationRepository: authenticationRepository)),
        storage: storage,
      );
    },
    blocObserver: AppBlocObserver(),
  );
}

void initControllers() {
  Get.put(ShelfController());
}
