import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:hearty/Draw%20chart/Month%20data.dart';
import 'package:hearty/Draw%20chart/chart_activity_status.dart';
import 'package:hearty/Draw%20chart/day%20data.dart';
import 'package:hearty/Location/location_home.dart';
import 'package:hearty/Reading%20sesnor%20dataset/sensor_data.dart';
import 'package:hearty/Skin%20disease/skin_disease.dart';
import 'package:hearty/Splash/login_page.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty%20function/About%20Us.dart';
import 'package:hearty/hearty%20function/Security_code.dart';
import 'package:hearty/hearty%20function/blog.dart';
import 'package:hearty/hearty%20function/language_choices.dart';
import 'package:hearty/hearty%20function/more_page.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../Location/location.dart';
import '../Reading sesnor dataset/notification_api.dart';
import 'use_yarsuma.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class HomePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
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

class CardItem{
  final String assets;
  final String title;
  final String subtitle;

  const CardItem({
    @required this.assets,
    @required this.title,
  @required this.subtitle
});
}

class _HomePageState extends State<HomePage>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  var locationMessage = "";
  var position;
  var Latitude;
  var Longitude;

  void initState(){
    getCurrentLocation();
  }


  void getCurrentLocation() async {
    position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator().getLastKnownPosition();
    print(lastPosition);

    setState(() {
      locationMessage = "Latitude : ${position.latitude}, Longitude :${position.longitude}";
      Latitude = position.latitude;
      Longitude = position.longitude;
    });
  }

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  int currentIndex = 0;

  File imageFile;

  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source:  ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.imageFile = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: ');
    }

  }

  Future pickCamera() async{
    try{
      final image = await ImagePicker().pickImage(source:  ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.imageFile = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: ');
    }
  }


  List<String> progress = ['Days', 'Weekly', 'Monthly'];
  String selectedItem = 'Days';

  List<CardItem> items = [
    CardItem(
      assets : 'assets/image/10.jpg',
      title : 'Skin Disease Detection',
      subtitle: 'We proposed an image '
          'processing-based method to detect skin diseases. '
          'This method takes the digital image of disease '
          'effect skin area, then use image analysis to identify the type of disease.',
    ),
    CardItem(
        assets: 'assets/image/R.jpg',
        title: 'Reading Sensors Data',
        subtitle: 'we proposed our livestock device that '
            'predicts the disease by getting the data '
            'from sensors and asking additional oral '
            'questions from farmers. Finally, we recommend how they treat their cattle.')
  ];

  final List link = [
    BlogPage(),
    MorePage(),
    ];
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
        'DarkTheme' : 'LightTheme';

    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'message_34'),
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
                }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
        //SizedBox(height: MediaQuery.of(context).size.height * 0.00000005,),
            Container(
              height: 380,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SkinDisease()),);
                    },
                    child: Container(
                    height: 350,
                    width: 300,
                    child : Card(
                      clipBehavior: Clip.antiAlias,
                      shadowColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        height: 200,
                        width: 350,
                        //padding: EdgeInsets.all(12),
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
                            Image(image: AssetImage('assets/image/10.jpg'),
                            height: 170,
                            width: 300,
                            fit: BoxFit.cover,),
                            Text(getTranslated(context, 'message_48'), style: TextStyle(
                                fontSize: 21,
                                //color: Color(0xFF363f93),
                                fontWeight: FontWeight.bold
                            ),),
                            Divider(color: Colors.black,),
                            Text(getTranslated(context, 'message_49'),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white60,
                              ),)
                          ],
                        )
                      )
                    )
                  )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => securityCode()),);
                        },
                        child: Container(
                            height: 350,
                            width: 300,
                            child : Card(
                                clipBehavior: Clip.antiAlias,
                                shadowColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                    height: 200,
                                    width: 300,
                                    //padding: EdgeInsets.all(12),
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
                                        Image(image: AssetImage('assets/image/R.jpg'),
                                          height: 170,
                                          width: 350,
                                          fit: BoxFit.cover,),
                                        Text(getTranslated(context, 'message_55'), style: TextStyle(
                                            fontSize: 21,
                                            //color: Color(0xFF363f93),
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Divider(color: Colors.black,),
                                        Text(getTranslated(context, 'message_56'),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white60,
                                          ),)
                                      ],
                                    )
                                )
                            )
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => securityCodeL(Latitude, Longitude)),);
                        },
                        child: Container(
                            height: 350,
                            width: 300,
                            child : Card(
                                clipBehavior: Clip.antiAlias,
                                shadowColor: Colors.amber,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Container(
                                    height: 200,
                                    width: 350,
                                    //padding: EdgeInsets.all(12),
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
                                        Image(image: AssetImage('assets/image/locat.png'),
                                          height: 170,
                                          width: 300,
                                          fit: BoxFit.cover,),
                                        Text(getTranslated(context, 'message_58'), style: TextStyle(
                                            fontSize: 21,
                                            //color: Color(0xFF363f93),
                                            fontWeight: FontWeight.bold
                                        ),),
                                        Divider(color: Colors.black,),
                                        Text(getTranslated(context, 'message_59'),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white60,
                                          ),)
                                      ],
                                    )
                                )
                            )
                        )),
                  ),
                ]),
            ),

            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  getTranslated(context, 'message_65'),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,),
                ),
                Container(
                  width: 95,
                  height: 35,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Theme.of(context).primaryColor,Theme.of(context).accentColor,]),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DropdownButton<String>(
                        value: selectedItem,
                          items: progress.map((prog) =>
                          DropdownMenuItem<String>
                            ( value: prog,
                              child: Text(prog, style: TextStyle(
                                fontSize: 14
                              ),))).toList(),
                          onChanged: (prog) => setState(() => selectedItem = prog)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 15,),

            Container(
              width: MediaQuery.of(context).size.width*0.9,
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(30)
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    child: LineChart(
                      selectedItem == 'Days' ? activityDataDay() :
                          selectedItem == 'Weekly' ? activityData() : activityDataMonth()
                    ),
                  ),
                  Padding(padding: const EdgeInsets.all(10),
                    child: Text(
                      getTranslated(context, 'message_69'), style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                    ),
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            Container(
              height: 220,
              child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 5,
                      child: Material(
                        child: Container(
                            height: 220.0,
                            width: MediaQuery.of(context).size.width*0.9,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only
                                (bottomLeft: Radius.circular(50.0),
                              ),
                              boxShadow: [BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: new Offset(-10.0, 10.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 4.0)],
                            )
                        ),
                      ),
                    ),
                    Positioned(
                        top: 0,
                        left: 10,
                        right: 10,
                        child: Card(
                          elevation: 10.0,
                          shadowColor: Colors.grey.withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Container(
                            height: 190,
                            width: MediaQuery.of(context).size.width/1.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage('assets/image/2.gif')
                                )
                            ),
                          ),
                        )),
                  ]
              ),
            )
          ]  ),
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
