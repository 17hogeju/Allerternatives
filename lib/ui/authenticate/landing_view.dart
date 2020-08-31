import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:allerternatives/ui/widgets/loading.dart';
import 'package:flutter/material.dart';

class Landing extends StatefulWidget {
  final Function toggleView;

  Landing({this.toggleView});

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    print('landing $loading');
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: primaryColor,
                elevation: 0.0,
                title: Text('Register or Sign In',
                    style: TextStyle(color: Colors.white))),
            body: Stack(children: <Widget>[
              new Container(
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage("assets/images/plates.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              new Container(
                decoration: new BoxDecoration(
                  color: primaryColorLight.withOpacity(.8),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    Text(
                      "Aller-Ternatives",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Alba",
                        fontSize: 35,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * .05),
                    ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 100,
                        height: 60.0,
                        child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.white,
                            child: Text(
                              'Sign In',
                              style:
                                  TextStyle(color: primaryColor, fontSize: 24),
                            ),
                            onPressed: () {
                              // go to sign in page
                              widget.toggleView(true);
                            })),
                    SizedBox(height: 20.0),
                    ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width - 100,
                        height: 60.0,
                        child: FlatButton(
                            shape: new RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 2.0),
                                borderRadius: new BorderRadius.circular(30.0)),
                            color: Colors.transparent,
                            child: Text(
                              'Register',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                            onPressed: () {
                              // go to sign in page
                              widget.toggleView(false);
                            })),
                  ],
                ),
              )
            ]));
  }
}

/*
return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text('Register or Sign In')
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            RaisedButton( // Sign in button
              color: primaryColor,
              child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white)
              ),
              onPressed: () {
                // go to sign in page

              }
            ),
            SizedBox(height: 20.0),
            RaisedButton(
              color: primaryColor,
              child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white)
              ),
              onPressed:() {
                //go to register page
                widget.togglePage(PageTypeHelper.getValue(PageType.register));
              }
            )
          ],
        ),
      )
    );
 */
