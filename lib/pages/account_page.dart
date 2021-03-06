import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geo_me/pages/loading_page.dart';
import 'package:geo_me/pages/login_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
            ),
          ),
        ),
        title: const Text('Account'),
        actions: [
          CupertinoButton(
            child: const Icon(Icons.logout),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoadingPage()),
              );
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                ModalRoute.withName('/'),
              );
            },
          )
        ],
      ),
    );
  }
}
