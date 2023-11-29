import 'package:flutter/material.dart';
import 'demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String AMHARIC = 'am';
const String AFAAN_OROMO = 'or';
const String SOMALIL = 'sl';
const String TIGRAY = 'tr';
const String WOLAYTTA = 'uk';
const String SWAHILI = 'sw';

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case AMHARIC:
      return Locale(AMHARIC, "AM");
    case AFAAN_OROMO:
      return Locale(AFAAN_OROMO, "ET");
    case SOMALIL:
      return Locale(SOMALIL, "ET");
    case SWAHILI:
      return Locale(SWAHILI, 'SW');
    case WOLAYTTA:
      return Locale(WOLAYTTA, "ET");
    case TIGRAY:
      return Locale(TIGRAY, "ET");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}