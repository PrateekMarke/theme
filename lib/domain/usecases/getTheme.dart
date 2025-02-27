import 'package:flutter/material.dart';
import 'package:theme/domain/entities/theme_entity.dart';

import '../repository/theme_repository.dart';

class GetThemeUseCase {
  final ThemeRepository repository;

  GetThemeUseCase(this.repository);

  Future<ThemeEntity> call() async {
    final savedTheme = await repository.getSavedTheme();
    final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
    final themeData = (savedTheme == AppTheme.system)
        ? (brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light())
        : (savedTheme == AppTheme.dark ? ThemeData.dark() : ThemeData.light());

    return ThemeEntity(selectedTheme: savedTheme, themeData: themeData);
  }
}
