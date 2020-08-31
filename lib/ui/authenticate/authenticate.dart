import 'package:allerternatives/ui/authenticate/landing_view.dart';
import 'package:allerternatives/ui/authenticate/register_view.dart';
import 'package:allerternatives/ui/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn;

  void toggleView(bool view) {
    //print(showSignIn.toString());
    setState(() => showSignIn = view);
  }

  @override
  Widget build(BuildContext context) {
    switch (showSignIn) {
      case true:
        {
          return SignIn(toggleView: toggleView);
        }
        break;
      case false:
        {
          return RegisterView(toggleView: toggleView);
        }
        break;
      default:
        {
          print('ON landing');
          return Landing(toggleView: toggleView);
        }
    }
  }
}
