import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class MyHomePage extends StatefulWidget {
  final Latitude;
  final Longitude;
  final serial;
  MyHomePage(this.Latitude, this.Longitude, this.serial, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(this.Latitude, this.Longitude, this.serial);
}

class _MyHomePageState extends State<MyHomePage> {

  final Latitude;
  final Longitude;
  final serial;
  _MyHomePageState(this.Latitude, this.Longitude, this.serial);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      retriveDataAll();
    });
  }

  final dref = FirebaseDatabase.instance.reference().child('date').orderByChild('Time_and_Date');

  List<String> Lati = [];
  List<String> Long = [];

  var cattlelat;
  var cattlelong;

  retriveDataAll() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL
    print('Abdi desta boos12');
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

    var url = "https://hearty-project-default-rtdb.firebaseio.com/"+"GPS_Data.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print('Abdi desta boos21');
      Lati.clear();
      Long.clear();
      extractedData.forEach((blogId, blogData) {
        if (serial == blogData["Serial_Code"]){
          Lati.add(blogData["Latitude"]);
          Long.add(blogData["Longitude"]);
        };
      });
      setState(() {
        print('Lati : ${Lati}');
        print('Long : ${Long}');
        cattlelat = double.parse(Lati[Lati.length - 1]);
        cattlelong = double.parse(Long[Long.length - 1]);
        print(cattlelat);
        print(cattlelong);
        Navigator.of(context).pop();
      });
    } catch (error) {
      throw error;
      Navigator.of(context).pop();
    }
  }

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(7.6890311, 36.8198492),
    zoom: 14.4746,
  );

  Future<Uint8List> getMarker() async {
    ByteData byteData = await DefaultAssetBundle.of(context).load("assets/image/192x192.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(cattlelat, cattlelong);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("Cattle"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }


      _locationSubscription = _locationTracker.onLocationChanged().listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
              bearing: 192.8334901395799,
              target: LatLng(cattlelat, cattlelat),
              tilt: 0,
              zoom: 18.00)));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'message_60')),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialLocation,
        markers: Set.of((marker != null) ? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },

      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.location_searching),
          onPressed: () {
            getCurrentLocation();
          }),
    );
  }
}
