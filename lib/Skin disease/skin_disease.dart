import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hearty/Skin%20disease/result_display.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty%20function/bottom%20navigator.dart';
import 'package:hearty/hearty%20function/home_page.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:tflite/tflite.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class SkinDisease extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _SkinDiseaseState();
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


class _SkinDiseaseState extends State<SkinDisease>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  File imageFile;
  List _output;
  String eyosi;
  bool isDone = false;
  bool isimage = true;

  @override
  void initState(){
    super.initState();
    loadModel().then((value) => setState((){
    }));
  }

  dectectImage(File image) async{
    var output = await Tflite.runModelOnImage(
      path: image.path,
      numResults:3,
      threshold: 0.4,
      imageMean: 127.5,
      imageStd: 127.5
    );
    await Future.delayed(Duration(milliseconds: 1000000), () {
      CircularProgressIndicator();
    });
    setState(() {
      _output = output;
      eyosi = _output[0]['label'];
      isDone = true;
      print(eyosi);
    });
    Navigator.of(context).pop();
  }

  loadModel() async{
    await Tflite.loadModel(
      model : 'assets/image/tf_lite_model.tflite',
      labels : 'assets/image/label.txt'
    );
  }

  @override
  void dispose(){
    //TODO: implement dispose
    super.dispose();
  }


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

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_50'),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0.5,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyBottomBarDemo()),);
            },
          ),
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

                  Column(
                      children : [
                        //SizedBox(height: MediaQuery.of(context).size.height * 0.005,),
                        Container(
                            padding: EdgeInsets.all(32),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  imageFile != null ? Image.file(
                                    imageFile, width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height/3,
                                  ) : Image.asset("assets/image/10.jpg",
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height/3,),
                                  const SizedBox(height: 16,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      buildButton(
                                        title: 'Pick Gallery',
                                        icon: Icons.image_outlined,
                                        onClicked: ()=> pickImage(),
                                      ),
                                      const SizedBox(width: 15,),
                                      buildButton(
                                        title: 'Pick Camera',
                                        icon: Icons.camera_alt_outlined,
                                        onClicked: ()=>pickCamera(),
                                      ),
                                    ],
                                  ),
                                ])
                        ),
                        isimage == false ? Text('please Enter your cattle Skin Image ',
                        style: TextStyle(color: Colors.red, fontSize: 18),) :
                        Container(), SizedBox(height: 4,),
                        ElevatedButton (
                          onPressed: (){
                            //dectectImage(imageFile);
                            //print(eyosi);
                            imageFile != null ? Navigator.push(context, MaterialPageRoute(builder: (context) => reultSkin(imageFile)),)
                                : setState((){
                              isimage = false;
                            });
                            },
                          child: Text(getTranslated(context, 'message_51'),
                            style: TextStyle(fontSize: 20),),
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            side: BorderSide(width: 2, color: Colors.greenAccent),
                            shape: RoundedRectangleBorder( //to set border radius to button
                                borderRadius: BorderRadius.circular(30)
                            ),
                          ),),
                        SizedBox(height: 16,),
                        Container(
                            height: MediaQuery.of(context).size.height*0.1,
                            width: MediaQuery.of(context).size.width*0.9,
                            child: Column(
                                children: [
                                  Text(getTranslated(context, 'message_52'),
                                    style: TextStyle(
                                      fontSize: 16,
                                     // color: Colors.grey,
                                    ),),
                                  Text(getTranslated(context, 'message_53'),
                                    style: TextStyle(
                                      fontSize: 16,
                                      // color: Colors.grey,
                                    ),)])
                        )
                      ] ),
                ]  ),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
          fit: StackFit.expand,
          children : [
            Positioned(
              right: 20,
              bottom: 8,
              child: FloatingActionButton.extended(
                onPressed: (){
                  setState(() {
                    imageFile = null;
                    _output = null;
                    isimage = true;
                  });
                },
                label: const Text('Delete'),
                icon: const Icon(Icons.delete),
                //backgroundColor: Colors.pink,
              ),
            ),
          ]
      ),
    );
  }

  Widget buildButton({
    @required String title,
    @required IconData icon,
    @required VoidCallback onClicked,
  }) => FloatingActionButton(
    heroTag: Text("btn1"),
    onPressed: onClicked,
    tooltip: title,
    child: new Icon(icon),
    backgroundColor: Colors.lightGreen,
  );

}