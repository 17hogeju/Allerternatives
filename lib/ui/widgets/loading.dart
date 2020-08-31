import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColorLight,
      child: Center(
        child: SpinKitChasingDots(
          color: primaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}
