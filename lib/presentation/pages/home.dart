import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme/domain/entities/theme_entity.dart';
import '../bloc/theme_bloc.dart';
import '../bloc/theme_event.dart';
import '../bloc/theme_state.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return DropdownButton<AppTheme>(
              value: state.theme.selectedTheme, // Now reflects "System" selection
              items: AppTheme.values.map((AppTheme theme) {
                return DropdownMenuItem<AppTheme>(
                  value: theme,
                  child: Text(theme.toString().split('.').last),
                );
              }).toList(),
              onChanged: (AppTheme? newTheme) {
                if (newTheme != null) {
                  context.read<ThemeBloc>().add(ChangeThemeEvent(newTheme));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
