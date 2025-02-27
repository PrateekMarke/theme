import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/data/datasource/local/theme_source.dart';
import 'package:theme/data/repository/themeRepository_impl.dart';
import 'package:theme/domain/usecases/getTheme.dart';
import 'package:theme/domain/usecases/saveTheme.dart';
import 'package:theme/presentation/bloc/theme_bloc.dart';
import 'package:theme/presentation/bloc/theme_state.dart';
import 'package:theme/presentation/pages/home.dart';

void main() {
  final localDataSource = ThemeLocalDataSourceImpl();
  final repository = ThemeRepositoryImpl(localDataSource);
  final getThemeUseCase = GetThemeUseCase(repository);
  final saveThemeUseCase = SaveThemeUseCase(repository);

  runApp(MyApp(getThemeUseCase, saveThemeUseCase));
}

class MyApp extends StatelessWidget {
  final GetThemeUseCase getThemeUseCase;
  final SaveThemeUseCase saveThemeUseCase;

  const MyApp(this.getThemeUseCase, this.saveThemeUseCase, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeBloc(getThemeUseCase: getThemeUseCase, saveThemeUseCase: saveThemeUseCase),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Theme',
            theme: state.theme.themeData,
            darkTheme: state.theme.themeData,
            home: const MyHomePage(),
          );
        },
      ),
    );
  }
}
