import 'package:flutter/material.dart';
import 'package:flutterfirstapp/screens/home_screen.dart';
import 'package:flutterfirstapp/screens/myaccount/profile_screen.dart';
import './screens/auth/signup_screen.dart';
import './screens/auth/login_screen.dart';
import './screens/search_screen.dart';

/**
 * Screen Import
 */
import 'screens/details_screen.dart';
import 'screens/landing_screen.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
  //   runApp(MyApp());
  //   }
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Flutter Demo",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.teal),
        //home: HomeScreen(),
        //initialRoute: '/details-screen',
        routes: {
          '/': (_) => LandingScreen(),
          '/details-screen': (_) => DetailsScreen(),
          '/login-screen': (_) => LoginScreen(),
          '/signup-screen': (_) => SignupScreen(),
          '/home-screen': (_) => HomeScreen(),
          '/profile-screen': (_) => ProfileScreen(),
          '/search-screen': (_) => SearchScreen()
        });
  }

  
}
