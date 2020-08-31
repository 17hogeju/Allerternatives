import 'dart:ui';

import 'package:allerternatives/Services/auth.dart';
import 'package:allerternatives/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  final Function toggleView;

  RegisterView({this.toggleView});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    print('register $loading');
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => widget.toggleView(null),
          ),
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text('Register', style: TextStyle(color: Colors.white)),
        ),
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
              color: Colors.white.withOpacity(.8),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  Text(
                    "AT",
                    style: TextStyle(
                        color: primaryColor, fontFamily: "Alba", fontSize: 50),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * .05),
                  TextFormField(
                    style: TextStyle(color: primaryColor),
                    decoration: new InputDecoration(
                        hintStyle: TextStyle(color: primaryColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: primaryColorDark, width: 2.0)),
                        focusColor: accentColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: primaryColor, width: 2.0)),
                        hintText: 'email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    style: TextStyle(color: primaryColor),
                    decoration: new InputDecoration(
                        hintStyle: TextStyle(color: primaryColor),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: BorderSide(
                                color: primaryColorDark, width: 2.0)),
                        focusColor: accentColor,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide:
                                BorderSide(color: primaryColor, width: 2.0)),
                        hintText: 'password'),
                    obscureText: true,
                    validator: (val) => val.length < 6
                        ? 'Enter a password 6+ chars long'
                        : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(height: 20.0),
                  ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width - 100,
                      height: 60.0,
                      child: FlatButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)),
                          color: primaryColor,
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              dynamic result =
                                  await _auth.registerWithEmailAndPassword(
                                      email, password);
                              if (result == null) {
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email';
                                });
                              }
                            }
                          })),
                  SizedBox(height: 12.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}

/*
import 'package:flutter/material.dart';
import 'package:allerternatives/Services/auth.dart';
import 'package:allerternatives/Screens/authenticate/page_type.dart';


class RegisterView extends StatefulWidget {

  final Function togglePage;
  Register({ this.togglePage});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0.0,
          title: Text('Register'),
          actions: <Widget>[
            FlatButton.icon(
                icon: Icon(Icons.home),
                label: Text('Go Back'),
                onPressed: () {
                  widget.togglePage(PageTypeHelper.getValue(PageType.landing));
                }
            )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField( // Username
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField( // Password
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  obscureText: true,
                  validator: (val) => val.length < 8 ? 'Enter a password of 8 or more characters' : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  }
              ),
              SizedBox(height: 20.0),
              RaisedButton( // Register button
                  color: primaryColor,
                  child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white)
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() => error = 'Please supply a valid email');
                      }
                      widget.togglePage(PageTypeHelper.getValue(PageType.landing));
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Input Received"),
                            content: Text("You may now sign in to the application"),
                          );
                        }
                      );
                    }
                  }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */
