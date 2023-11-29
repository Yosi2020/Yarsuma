import 'package:flutter/material.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hearty/hearty%20function/Security_code.dart';
import 'package:permission/permission.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';


class LocationHome extends StatefulWidget {
  final Latitude;
  final Longitude;
  final serial;
  LocationHome(this.Latitude, this.Longitude, this.serial, {Key key});

  @override
  State<LocationHome> createState() => _LocationHomeState(this.Latitude, this.Longitude, this.serial);
}

class _LocationHomeState extends State<LocationHome> {

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  final Latitude;
  final Longitude;
  final serial;
  _LocationHomeState(this.Latitude, this.Longitude, this.serial);

  void initState(){
    retriveDataAll();
    eyu();
  }

  final dref = FirebaseDatabase.instance.reference().child('date').orderByChild('Time_and_Date');

  List<String> Lati = [];
  List<String> Long = [];

  var cattlelat;
  var cattlelong;
  //var destination;
  var cattlelat_old;
  var cattlelong_old;

  retriveDataAll() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL
    print('Abdi desta boos12');

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
      });
    } catch (error) {
      throw error;
    }
  }

  void eyu() {
    if (cattlelat == null && cattlelong == null){
      cattlelat = Latitude;
      cattlelong = Longitude;
    }
    }

  get destination => LatLng(cattlelat, cattlelong);

  static const _initialCameraPosition = CameraPosition(
    target: LatLng(7.6890311, 36.8198492),
    zoom: 11.5,
  );

  final Set<Polyline> polyline = {};

  GoogleMapController _controller;
  List<LatLng> routeCoords;
  GoogleMapPolyline googleMapPolyline =
  new GoogleMapPolyline(apiKey: "AIzaSyBdmQv-GMAjXftHSx5yYj9KKmPmpsNoODw");

  getsomePoints() async {
    var permissions = await Permission.getPermissionsStatus([PermissionName.Location]);
    if (permissions[0].permissionStatus == PermissionStatus.notAgain) {
      var askpermissions =
      await Permission.requestPermissions([PermissionName.Location]);
    } else {
      routeCoords = await googleMapPolyline.getCoordinatesWithLocation(
          origin: LatLng(Latitude, Longitude),
          destination: destination,
          mode: RouteMode.driving);
    }
  }

  Marker _origin;
  Marker _destination;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(getTranslated(context, 'message_60')),
          actions: [
            if (_origin != null)
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: Text(getTranslated(context, 'message_61')),
              ),
            if (_destination != null)
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600),
                ),
                child: Text(getTranslated(context, 'message_62')),
              )
          ],
        ),
        body: GoogleMap(
          myLocationButtonEnabled: false,
          onMapCreated: onMapCreated,
          polylines: polyline,
          initialCameraPosition:
          CameraPosition(target: LatLng(Latitude, Longitude), zoom: 9.5),
          mapType: MapType.normal,
          markers:  {
            if (_origin != null) _origin,
            if (_destination != null) _destination
          },
        ));
  }

  void onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;

      polyline.add(Polyline(
          polylineId: PolylineId('route1'),
          visible: true,
          points: routeCoords,
          width: 4,
          color: Colors.red,
          startCap: Cap.roundCap,
          endCap: Cap.buttCap));

      _destination = Marker(
        markerId: const MarkerId('destination'),
        infoWindow: InfoWindow(title: getTranslated(context, 'message_63')),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        position: destination,
      );

      _origin = Marker(
        markerId: const MarkerId('origin'),
        infoWindow: InfoWindow(title: getTranslated(context, 'message_64')),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        position: LatLng(Latitude, Longitude),
      );
    });
  }
}
