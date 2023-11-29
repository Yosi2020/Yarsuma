import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hearty/Splash/splash_screen.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:hearty/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'localization/demo_localization.dart';
import 'localization/language_constants.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) :super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  static final String title = 'Localization';

  Locale _locale;
  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context)  => ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
  builder: (context, _){
      final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Cattle Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: MyThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      locale: _locale,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('am', 'AM'),
        Locale('or', 'ET'),
        Locale('sl', 'ET'),
        Locale('uk', 'ET'),
        Locale('tr', 'ET'),
        Locale('sw', 'SW')
      ],
      localizationsDelegates: const [
        DemoLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      home: FutureBuilder(
      future: _initialization,
      builder: (context, snapshot){
        if(snapshot.hasError){
          print("Error");
        }
        if (snapshot.connectionState == ConnectionState.done){
          return SplashScreen(title: 'Cattle Demo');
        }
        return CircularProgressIndicator();
      },
    ),
    );
  },);
}