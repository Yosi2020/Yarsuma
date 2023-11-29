import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hearty/hearty%20function/bottom%20navigator.dart';
import 'package:hearty/hearty%20function/home_page.dart';
import 'widgets/theme_helper.dart';

import 'forget_password.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  String email = '';
  String password = '';

  double _headerHeight = 250;
  Key _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                  child: Column(
                    children: [
                      Text(
                        getTranslated(context, 'message_1'),
                        style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        getTranslated(context, 'message_2'),
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextField(
                                  decoration: ThemeHelper().textInputDecoration(getTranslated(context, 'message_3'), getTranslated(context, 'message_4'),),
                                  onChanged: (value) => setState(() => email = value),
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  obscureText: isHiddenPassword,
                                  onChanged: (value) => setState(() => password = value),
                                  decoration: InputDecoration(
                                    labelText: getTranslated(context, 'message_5'),
                                    hintText: getTranslated(context, 'message_6'),
                                    fillColor: Colors.white10,
                                    filled: true,
                                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                    focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                    suffixIcon: InkWell(
                                      onTap: _togglePassword,
                                      child:isHiddenPassword ? Icon(
                                        Icons.visibility,
                                      ): Icon(Icons.visibility_off),
                                    ),),
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return getTranslated(context, 'message_6');
                                    }
                                    return null;
                                  },
                                ),
                                decoration: ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,0,10,20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                  },
                                  child: Text( getTranslated(context, 'message_7'), style: TextStyle( color: Colors.grey, ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(getTranslated(context, 'massage_8'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                  ),
                                  onPressed: (){
                                    create();
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10,20,10,20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(
                                    TextSpan(
                                        children: [
                                          TextSpan(text: getTranslated(context, 'message_9'),),
                                          TextSpan(
                                            text: getTranslated(context, 'message_10'),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                          ),
                                        ]
                                    )
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                  )
              ),
            ),
          ],
        ),
      ),
    );

  }

  bool isHiddenPassword = true;
  void _togglePassword(){
    if(isHiddenPassword == true){
      isHiddenPassword = false;
    }
    else isHiddenPassword = true;
    setState(() {
      isHiddenPassword = isHiddenPassword;
    });
  }

  void create() {
    String Email = email.trim();
    String Password = password.trim();
    login(Email, Password);
  }

  Future<void> login(String Email, Password) async {
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: Email, password: Password)
        .then((value) {
      Navigator.of(context).pop();
          Navigator.of(context).push(
        MaterialPageRoute(builder: (context)=>MyBottomBarDemo())
    );})
        .catchError((error) {
      Navigator.of(context).pop();
        _showAlertDialog("Image Data Collection for AI",
            "Problem on sending Your request, please try again.");});
  }

  void _showAlertDialog(String title, String message){
    var alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new TextButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage())
              );
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }
}