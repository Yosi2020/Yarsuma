import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';


class LanguageChoice extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _LanguageChoiceState();
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


class _LanguageChoiceState extends State<LanguageChoice>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_44'),
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
                children: <Widget>[
                  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
                  SizedBox(height: 16,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<Language>(
                      onChanged: (Language language) {
                        _changeLanguage(language);
                      },
                      items: Language.languageList()
                          .map<DropdownMenuItem<Language>>(
                            (e) => DropdownMenuItem<Language>(
                          value: e,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                e.flag,
                                style: TextStyle(fontSize: 30),
                              ),
                              Text(e.name)
                            ],
                          ),
                        ),
                      )
                          .toList(),
                    ),
                  ),
        ]
            ))
    );
  }

}