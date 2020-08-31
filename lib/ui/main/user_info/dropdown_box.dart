import 'package:allerternatives/Services/firestore_service.dart';
import 'package:allerternatives/models/user.dart';
import 'package:allerternatives/models/user_data.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:allerternatives/ui/widgets/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DropdownBox extends StatefulWidget {
  @override
  _DropdownBoxState createState() => _DropdownBoxState();
}

class _DropdownBoxState extends State<DropdownBox> {
  String _currentAllergen;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return new StreamBuilder<UserData>(
        stream: FirestoreService(uid: user.uid).userData,
        builder: (context, snapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance.collection("allergens").snapshots(),
                builder: (context, snap) {
                  if (!snap.hasData) {
                    return Loading();
                  } else {
                    List<DropdownMenuItem> allergenItems = [];
                    for (int i = 0; i < snap.data.documents.length; i++) {
                      DocumentSnapshot docSnap = snap.data.documents[i];
                      allergenItems.add(DropdownMenuItem(
                        child: Text(
                          docSnap.documentID,
                          style: TextStyle(color: lightGreyText),
                        ),
                        value: "${docSnap.documentID}",
                      ));
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButtonHideUnderline(
                            child: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          width: MediaQuery.of(context).size.width * .8 - 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white),
                          child: DropdownButton(
                            items: allergenItems,
                            onChanged: (allergenValue) {
                              _currentAllergen = allergenValue;
                              setState(() {
                                _currentAllergen = allergenValue;
                              });
                            },
                            value: _currentAllergen,
                            isExpanded: false,
                            hint: new Text(
                              "Choose allergen",
                              style: TextStyle(color: lightGreyText),
                            ),
                          ),
                        )),
                        SizedBox(
                          width: 10.0,
                        ),
                        ClipOval(
                          child: Material(
                            color: primaryColor,
                            child: InkWell(
                              splashColor: Theme.of(context).primaryColorLight,
                              child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: new Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  )),
                              onTap: () async {
                                await FirestoreService(uid: user.uid)
                                    .updateUserData(_currentAllergen);
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  }
                },
              )
            ],
          );
        });
  }
}
