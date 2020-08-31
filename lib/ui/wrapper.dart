import 'package:allerternatives/models/user.dart';
import 'package:allerternatives/ui/authenticate/authenticate.dart';
import 'package:allerternatives/ui/main/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    final user = Provider.of<User>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return MyNavigation();
    }
  }
}
