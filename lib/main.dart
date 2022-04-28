import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/features/auth/auth_checker.dart';
import 'package:geo_me/providers.dart';

import 'pages/error_screen.dart';
import 'pages/loading_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Geo ME',
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(19, 136, 8, 1),
          onPrimary: Colors.white,
          primaryContainer: Colors.black,
          secondary: Color.fromRGBO(124, 252, 0, 1),
          onSecondary: Colors.white,
          secondaryContainer: Colors.black,
        ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(19, 136, 8, 1),
          onPrimary: Colors.black,
          primaryContainer: Colors.white,
          secondary: Color.fromRGBO(0, 66, 37, 1),
          onSecondary: Colors.black,
          secondaryContainer: Colors.white,
        ),
      ),

      home: initialize.when(data: (data) {
        return const AuthChecker();
      }, error: (e, stackTrace) {
        ErrorScreen(e, stackTrace);
        return null;
      }, loading: () {
        return const LoadingPage();
      }),
      // initialRoute: '/login',
    );
  }
}
