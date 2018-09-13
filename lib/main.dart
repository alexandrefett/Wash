import 'package:wash_x/pages/beforeSetupPage.dart';
import 'package:wash_x/pages/setupPage.dart';
import 'package:wash_x/pages/authenticationPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'pages/homePage.dart';

void main() async {
  bool _isLoggedIn = false;
  FirebaseUser firebaseUser;

  firebaseUser = await FirebaseAuth.instance.currentUser();
  if (firebaseUser != null) {
    _isLoggedIn = true;
  } else {
    _isLoggedIn = false;
  }

  runApp(
    new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.blue,
        canvasColor: Colors.white,
      ),

     //  home: _isLoggedIn?HomePage(true):AuthenticationPage(),
      home: BeforeSetupPage(),
      // Building Page Routes
      routes: <String, WidgetBuilder>{
        // '/LoginPage': (BuildContext context) => new LoginPage(),
        // '/RegistrationPage': (BuildContext context) => new RegistrationPage(),
        '/HomePage': (BuildContext context) => new HomePage(false),
      },
    ),
  );
}
