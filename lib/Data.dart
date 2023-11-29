import 'package:firebase_database/firebase_database.dart';

class Data {
  final String latitude, longitude, temperature, rumination, heartbeat, email;

  Data({this.latitude, this.longitude, this.temperature,
      this.rumination, this.heartbeat, this.email});
}


//https://stackoverflow.com/questions/61508047/how-to-get-data-from-firebase-realtime-database-into-list-in-flutter
