import 'package:flutter/material.dart';
import 'package:givbooks/views/authentication/authentication.dart';
import 'package:givbooks/views/home/home_page.dart';

import 'bloc/app_bloc.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
