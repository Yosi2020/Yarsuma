import 'package:flutter/material.dart';
import 'package:hearty/Location/location_home.dart';
import 'package:hearty/Location/location_home111.dart';
import 'package:hearty/Reading%20sesnor%20dataset/sensor_data.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty function/bottom navigator.dart';

import '../Splash/widgets/theme_helper.dart';

class securityCodeL extends StatefulWidget {
  final Latitude;
  final Longitude;
  securityCodeL(this.Latitude, this.Longitude,{Key key}) : super(key: key);

  @override
  State<securityCodeL> createState() => _securityCodeLState(this.Latitude, this.Longitude,);
}

class _securityCodeLState extends State<securityCodeL> {
  final Latitude;
  final Longitude;
  _securityCodeLState(this.Latitude, this.Longitude);

  Key _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  double _headerHeight = 250;

  @override
  Widget build(BuildContext context) {
    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';
    return Scaffold(
        appBar: AppBar(
          title: Text('Security Code Checker'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomBarDemo()),);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
                  SizedBox(height: 15,),
                  SafeArea(
                    child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                        child: Column(
                          children: [
                            Text(
                              'please Enter your security code.',
                              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'This code is very useful to get your data fully from our database so please keep it properly',
                              style: TextStyle(color: Colors.grey),
                            ),
                            SizedBox(height: 30.0),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        decoration: ThemeHelper().textInputDecoration('securityCode', 'please enter your security code please'),
                                        onChanged: (value) => setState(() => email = value),
                                      ),
                                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    ),
                                    SizedBox(height: 30.0),
                                    Container(
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Text('Verify', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                        ),
                                        onPressed: (){
                                          //create();
                                          if (email != null && email.length >1){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(Latitude, Longitude, email)));
                                          }

                                        },
                                      ),
                                    ),

                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ),
                ]
            )
        )
    );
  }
}
