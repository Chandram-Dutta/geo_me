import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geo_me/pages/feed_page.dart';
import 'package:geo_me/pages/login_page.dart';
import 'package:validators/validators.dart';

import '../features/auth/providers/providers.dart';
import '../responsive/responsive.dart';
import 'loading_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                ],
              ),
            ),
          ),
          SizedBox(
            // height: 450,
            width: isDesktop(context, 800) ? 500 : 300,
            child: Column(
              children: [
                const Spacer(),
                Text(
                  "Sign Up",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                const EmailPart(),
                const SizedBox(
                  height: 20,
                ),
                const Spacer()
              ],
            ),
          ),
          Positioned(
              bottom: 20,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoButton(
                        child: const FaIcon(FontAwesomeIcons.google),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        child: const FaIcon(FontAwesomeIcons.apple),
                        onPressed: () {},
                      ),
                      CupertinoButton(
                        child: const FaIcon(FontAwesomeIcons.facebook),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}

class EmailPart extends ConsumerStatefulWidget {
  const EmailPart({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EmailPart> createState() => _EmailPartState();
}

class _EmailPartState extends ConsumerState<EmailPart> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _auth = ref.watch(authenticationProvider);
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _emailController,
            validator: (val) => !isEmail(val!) ? "Invalid Email" : null,
            autocorrect: false,
            decoration: InputDecoration(
              focusColor: Colors.black,
              floatingLabelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Email ID',
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter some text';
              }
              if (value.length < 5) {
                return 'Must be more than 5 charater';
              }
              return null;
            },
            obscureText: true,
            autocorrect: false,
            decoration: InputDecoration(
              focusColor: Colors.black,
              floatingLabelStyle: const TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: 'Password',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: isDesktop(context, 800) ? 500 : 300,
            child: MaterialButton(
              height: 40,
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadingPage()),
                  );
                  await _auth.signUpWithEmailAndPassword(
                      _emailController.text, _passwordController.text, context);

                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const FeedPage()),
                    ModalRoute.withName('/'),
                  );
                }
              },
              color: Theme.of(context).colorScheme.onPrimary,
              shape: const StadiumBorder(),
              child: const Text('Sign Up'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            width: isDesktop(context, 800) ? 500 : 300,
            child: MaterialButton(
              hoverColor: Theme.of(context).colorScheme.onSecondary,
              height: 40,
              elevation: 0,
              focusElevation: 0,
              hoverElevation: 0,
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              color: Colors.transparent,
              shape: const StadiumBorder(),
              child: Text(
                'Login Here',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
