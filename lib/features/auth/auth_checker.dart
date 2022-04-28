import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_me/features/auth/providers/providers.dart';
import 'package:geo_me/pages/feed_page.dart';
import 'package:geo_me/pages/loading_page.dart';

import '../../pages/error_screen.dart';
import '../../pages/login_page.dart';

class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  //  Notice here we aren't using stateless/statefull widget. Instead we are using
  //  a custom widget that is a consumer of the state.
  //  So if any data changes in the state, the widget will be updated.

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //  now the build method takes a new paramaeter ScopeReader.
    //  this object will be used to access the provider.

    //  now the following variable contains an asyncValue so now we can use .when method
    //  to imply the condition
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
      data: (data) {
        if (data != null) return const FeedPage();
        return const LoginPage();
      },
      loading: () => const LoadingPage(),
      error: (e, trace) => ErrorScreen(e, trace),
    );
  }
}
