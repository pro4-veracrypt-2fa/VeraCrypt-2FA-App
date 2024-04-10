import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:veracrypt_2fa_app/Routes.dart';
import 'package:veracrypt_2fa_app/page/home.dart';
import 'package:veracrypt_2fa_app/page/pairing.dart';
import 'package:veracrypt_2fa_app/page/request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock device orientation to portrait mode
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sofia Pro Soft',
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        colorScheme: ColorScheme.light(
          primary: Colors.teal.shade600,
          background: Colors.white,
          onPrimary: Colors.teal.shade600,
          inversePrimary: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: Routes.home,
  redirect: (context, state) async {
    // if (!(await StateWrapper.isPaired())) {
    //   return Routes.pairing;
    // }
    return state.fullPath;
  },
  routes: <RouteBase>[
    GoRoute(
      path: Routes.home,
      builder: (_, __) => const HomePage(),
    ),
    GoRoute(
      path: Routes.pairing,
      builder: (_, __) => PairingPage(),
    ),
    GoRoute(
      path: Routes.incomingRequest,
      builder: (_, __) => const IncomingRequestPage(),
    ),
  ],
);
