import 'package:allerternatives/Services/firestore_service.dart';
import 'package:allerternatives/models/user.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllergenBox extends StatelessWidget {
  final String allergenName;

  const AllergenBox({
    this.allergenName,
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          title: Text(allergenName),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              showAlertDialog(context, user, allergenName);
            },
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context, User user, String allergen) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(
      "Cancel",
      style: TextStyle(color: lightGreyText),
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text(
      "Continue",
      style: TextStyle(color: primaryColor),
    ),
    onPressed: () async {
      Navigator.of(context).pop();
      await FirestoreService(uid: user.uid).removeUserData(allergen);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Confirm"),
    content: Text("Are you sure you want to remove this allergen?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
