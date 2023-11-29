import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hearty/Splash/login_page.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty%20function/About%20Us.dart';
import 'package:hearty/hearty%20function/language_choices.dart';
import 'use_yarsuma.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'service.dart';
import 'service2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:launch_review/launch_review.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class MorePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MorePageState();
  }
}
// this used for list item
class MenuItem {
  final String text;
  const MenuItem({
    @required this.text,
  });
}

class MenuItems {
  static const List<MenuItem> itemsFirst =[
    AboutUs,
  ];
  static const AboutUs = MenuItem(
    text: 'About Us',
  );
}


class _MorePageState extends State<MorePage>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  launchurl1() async{
    final url = "http://linkedin.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl2() async{
    final url = "mailto:heartyplc.6@gmail.com";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl3() async{
    final url = "http://facebook.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl4() async{
    final url = "http://youtube.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }
  launchurl5() async{
    final url = "http://twitter.com/";
    if(await canLaunch(url)){
      await launch(url);
    }
    else{
      throw "Could not launch the url";
    }
  }

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_80'),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace:Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                )
            ),
          ),
          actions: [
            InkWell(
              onTap: (){
                share("https://heartyplc.com", "Yarsma Application");
              },
              child: Container(
                margin: EdgeInsets.only( top: 16, right: MediaQuery.of(context).size.width*0.025,),
                child: Stack(
                  children: <Widget>[
                    Icon(Icons.share),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<MenuItem>(
                onSelected: (item) => onSelected(context, item),
                itemBuilder: (context) =>[
                  ...MenuItems.itemsFirst.map(buildItem).toList(),
                ]
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            decoration:BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 1.0],
                    colors: [
                      Theme.of(context).primaryColor.withOpacity(0.2),
                      Theme.of(context).accentColor.withOpacity(0.5),
                    ]
                )
            ) ,
            child: ListView(
              children: [
                SizedBox(height: 200, child:
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage("assets/image/Black and Yellow Icon.png"),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "name",
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ]),),),),
                Row(
                    children :[
                      SizedBox(width: 20,),
                      Text(getTranslated(context, 'message_40'), style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor)),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.001,),
                      Switch.adaptive(value: themeProvider.isDarkMode,
                        onChanged: (value){
                          final provider = Provider.of<ThemeProvider>(context, listen: false);
                          provider.toggleTheme(value);
                        },
                      ),]),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                  title: Text(getTranslated(context, 'message_41'), style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Yarsuma()),);
                  },
                ),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.language, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  title: Text(getTranslated(context, 'message_43'),style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageChoice()),);
                  },
                ),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.star, size: _drawerIconSize,color: Colors.orangeAccent),
                  title: Text(getTranslated(context, 'message_45'),style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                  onTap: () {
                    rating();
                  },
                ),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.feedback_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  title: Text(getTranslated(context, 'message_46'),style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                  onTap: () {
                    launchurl2();
                    },
                ),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  title: Text(getTranslated(context, 'message_47'),style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                    //SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
        ),
        body: Column(
            children: [
              Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
              Text(getTranslated(context, 'message_73'), style: GoogleFonts.arsenal(
                  fontSize: 50,
              fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text(getTranslated(context, 'message_74'), style: GoogleFonts.sail(
                  fontSize: 45,
                  ),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.linkedin, size: 35,
                      color: Colors.blue,),
                    onTap: () {
                      launchurl1();
                    },
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.googlePlus, size: 35,
                      color: Colors.blue,),
                    onTap: () {
                      launchurl2();
                    },
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.facebook, size: 35,
                      color: Colors.blue,),
                    onTap: () {
                      launchurl3();
                    },
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.youtube, size: 35,
                      color: Colors.blue,),
                    onTap: () {
                      launchurl4();
                    },
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    child: FaIcon(
                      FontAwesomeIcons.twitter, size: 35,
                      color: Colors.blue,),
                    onTap: () {
                      launchurl5();
                    },
                  ),
                ],
              ),
              Divider(),
              SizedBox(height: 30,),
              Text(getTranslated(context, 'message_75'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        itemCount: products.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 0,
                          crossAxisSpacing: 10,
                          childAspectRatio: .70,
                        ),
                        itemBuilder: (context, index) => ItemCard(
                          product: products[index],
                          press: (){}
                        ),
                      ))),
            ],
          )
    );
  }

  Future<void> share(dynamic link, String title) async{
    await FlutterShare.share(
        title : "Welcome to Yarsma PLC",
        text: title,
        linkUrl: link,
        chooserTitle: 'Where You want to share'
    );
  }

  // this is for Menu list on the right concer

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
    value: item,
    // you can use row to put the icon and list
    child: Text(item.text),
  );

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.AboutUs:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AboutUs())
        );
        break;
    }
  }

  Future<void> rating() {
    LaunchReview.launch(
        androidAppId: "com.example.hearty");
  }

}