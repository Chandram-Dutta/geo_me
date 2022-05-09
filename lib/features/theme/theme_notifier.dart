import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/features/theme/themes.dart';

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier(AppTheme state) : super(state);

  ThemeData darkTheme() => AppTheme.darkTheme;
  ThemeData lightTheme() => AppTheme.lightTheme;
}
