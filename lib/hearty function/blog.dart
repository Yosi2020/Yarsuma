import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hearty/Splash/login_page.dart';
import 'package:hearty/hearty%20function/About%20Us.dart';
import 'package:hearty/hearty%20function/language_choices.dart';
import 'use_yarsuma.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class BlogPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _BlogPageState();
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

launchurl2() async{
  final url = "mailto:heartyplc.6@gmail.com";
  if(await canLaunch(url)){
    await launch(url);
  }
  else{
    throw "Could not launch the url";
  }
}

class _BlogPageState extends State<BlogPage>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_73'),
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
                      colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
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
                            backgroundImage: AssetImage("assets/image/1.jpg"),
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
                  title: Text(getTranslated(context, 'message_41'), style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),),
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Yarsuma()),)
                ),
                Divider(color: Theme.of(context).primaryColor, height: 1,),
                ListTile(
                  leading: Icon(Icons.language, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  title: Text(getTranslated(context, 'message_43'),style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LanguageChoice()),);
                    // Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
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
        body: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl: 'https://deboengineering.com/n/',
                    onWebViewCreated: (WebViewController webViewController){
                      _controller.complete(webViewController);
                    },
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