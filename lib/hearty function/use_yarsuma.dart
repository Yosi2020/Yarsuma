import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';


class Yarsuma extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _YarsumaState();
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


class _YarsumaState extends State<Yarsuma>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_41'),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
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
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
                  Card(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                          height: MediaQuery.of(context).size.height * 0.65,
                          width: 350,

                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Theme.of(context).primaryColor,
                                    Theme.of(context).accentColor,],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomRight
                              )
                          ),
                          child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Text(getTranslated(context, 'message_42'),
                                    style: TextStyle(
                                        fontSize: 16),),),
                              ]))),
                ]  )
        )
    );
  }

}