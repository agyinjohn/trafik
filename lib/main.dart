import 'package:animated_theme_switcher/animated_theme_switcher.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traffic/firebase_options.dart';
import 'package:traffic/screens/home_screen.dart';

import 'package:traffic/screens/splash_screen.dart';

import 'package:traffic/utils/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ThemeProvider(
      initTheme: Themes.darkTheme,
      builder: (ctx, theme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: "Montserrat",
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: FutureBuilder(
            future: checkLoginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              } else if (snapshot.hasData && snapshot.data == true) {
                return const HomeScreen();
              } else if (!snapshot.hasData && snapshot.data == false) {
                return const SplashScreen();
              } else {
                return const SplashScreen();
              }
            }),
      ),
    );
  }
}

Future<bool> checkLoginStatus() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isAthenticated') ?? false;
}
