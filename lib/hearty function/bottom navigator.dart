import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hearty/hearty%20function/blog.dart';
import 'package:hearty/hearty%20function/more_page.dart';
import 'home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class MyBottomBarDemo extends StatefulWidget {
  @override
  _MyBottomBarDemoState createState() => new _MyBottomBarDemoState();
}

class _MyBottomBarDemoState extends State<MyBottomBarDemo> {

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  int _pageIndex = 0;

  List<Widget> tabPages = [
    HomePage(),
    BlogPage(),
    MorePage()
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (index) => setState(() => _pageIndex = index),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: getTranslated(context, 'message_70')),
          BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.blog),
              label: getTranslated(context, 'message_71')),
          BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              label: getTranslated(context, 'message_72')),
        ],

      ),
      body: tabPages[_pageIndex],
    );
  }
}