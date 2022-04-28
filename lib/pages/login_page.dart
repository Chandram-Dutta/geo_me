import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/pages/feed_page.dart';
import 'package:geo_me/pages/loading_page.dart';
import 'package:geo_me/pages/signup_page.dart';
import 'package:validators/validators.dart';

import '../features/auth/providers/providers.dart';
import '../responsive/responsive.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                "Login",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Fields(),
              const SizedBox(
                height: 20,
              ),
              const Spacer()
            ],
          ),
        ),
      ],
    ));
  }
}

class Fields extends StatefulWidget {
  const Fields({Key? key}) : super(key: key);

  @override
  State<Fields> createState() => _FieldsState();
}

class _FieldsState extends State<Fields> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
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
            child: LoginButton(
                formKey: _formKey,
                emailController: _emailController,
                passwordController: _passwordController),
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
                  MaterialPageRoute(builder: (context) => const SignUpPage()),
                );
              },
              color: Colors.transparent,
              shape: const StadiumBorder(),
              child: Text(
                'Sign Up Here',
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

class LoginButton extends ConsumerWidget {
  const LoginButton({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _auth = ref.watch(authenticationProvider);
    return MaterialButton(
      height: 40,
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoadingPage()),
          );
          await _auth.signInWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
            context,
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const FeedPage()),
            ModalRoute.withName('/'),
          );
        }
      },
      color: Theme.of(context).colorScheme.onPrimary,
      shape: const StadiumBorder(),
      child: const Text('Login'),
    );
  }
}
