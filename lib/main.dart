import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/pages/account_page.dart';
import 'package:geo_me/pages/login_page.dart';
import 'package:geo_me/pages/signup_page.dart';

import 'pages/loading_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
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
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/account': (context) => const AccountPage(),
        '/loading': (context) => const LoadingPage(),
      },
      initialRoute: '/login',
    );
  }
}
