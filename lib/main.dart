import 'package:flutter/material.dart';
import 'package:login_register/Authenticating.dart';
import 'package:login_register/FirstPage.dart';
import 'package:login_register/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_register/model/user_repository.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => UserRepository.instance(),
      child: Consumer(
        builder: (context, UserRepository user, _) {
          switch (user.status) {
            case Status.Uninitialized:
            case Status.Unauthenticated:
              return LoginPage();
            case Status.Authenticating:
              return Authent();

            case Status.Authenticated:
              return FirstScreen();

          }
        },
      ),
    );
  }
}