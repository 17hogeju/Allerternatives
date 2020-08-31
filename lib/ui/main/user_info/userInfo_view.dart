import 'package:allerternatives/Services/auth.dart';
import 'package:allerternatives/Services/firestore_service.dart';
import 'package:allerternatives/models/user.dart';
import 'package:allerternatives/models/user_data.dart';
import 'package:allerternatives/ui/main/user_info/allergen_list.dart';
import 'package:allerternatives/ui/main/user_info/dropdown_box.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfoView extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamProvider<UserData>.value(
      value: FirestoreService(uid: user.uid).userData,
      child: Scaffold(
          backgroundColor: backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: primaryColor,
            title:
                Text('Aller-Ternatives', style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text('Log Out', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  await _auth.signOut();
                },
              )
            ],
          ),
          body: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              DropdownBox(),
              SizedBox(
                height: 20.0,
              ),
              AllergenList(),
            ],
          )),
    );
  }
}

/*
StreamProvider<DocumentSnapshot>.value(
                value: FirestoreService().allergens,
                child: Scaffold(
                    backgroundColor: backgroundColor,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      iconTheme: IconThemeData(color: Colors.white),
                      backgroundColor: primaryColor,
                      title: Text('Aller-Ternatives',
                          style: TextStyle(color: Colors.white)),
                      actions: <Widget>[
                        FlatButton.icon(
                          icon: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          label: Text('Log Out',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            await _auth.signOut();
                          },
                        )
                      ],
                    ),
                    body: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),
                        DropdownBox(),
                        SizedBox(
                          height: 20.0,
                        ),
                        AllergenList(),
                      ],
                    )));
          } else {
            return HomeView();
          }
        });
 */
