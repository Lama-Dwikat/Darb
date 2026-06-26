//
// import 'package:flutter/material.dart';
// import 'Screens/Splash_screen.dart'; // make sure path is correct
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Darb',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//
//       // 👇 START APP FROM SPLASH
//       home: const SplashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'Screens/Splash_screen.dart';
import 'Screens/loading_screen.dart';
import 'Screens/trip_screen.dart';
import 'Screens/site_details_screen.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Darb',

      theme: AppTheme.light,

      home: const SplashScreen(),

      routes: {
        '/loading': (context) => const LoadingScreen(),
        '/trip': (context) => const TripScreen(),
        '/site-details': (context) => const SiteDetailsScreen(),
      },
    );
  }
}