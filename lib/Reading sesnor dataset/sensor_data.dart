import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:hearty/Reading%20sesnor%20dataset/notification_api.dart';
import 'package:hearty/Reading%20sesnor%20dataset/result_display.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty%20function/Security_code.dart';
import 'package:hearty/services/theme_provider.dart';
import 'package:provider/provider.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

import 'package:hearty/Draw%20chart/Month%20data.dart';
import 'package:hearty/Draw%20chart/chart_activity_status.dart';
import 'package:hearty/Draw%20chart/day%20data.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class SensorData extends StatefulWidget{
  final String serial;
  SensorData(this.serial);

  @override
  State<StatefulWidget> createState() {
    return _SensorDataState(this.serial);
  }
}
// this used for list item

class _SensorDataState extends State<SensorData>{
  final String serial;
  _SensorDataState(this.serial);

  var questionIndex = 0;
  var questions = [
    'Age of your cattle?',
    'Sex of your cattle?',
    'is your cattle have Dehydration?',
    'is your cattle losing its weight?',
    'is your cattle have rough hair coat?',
    'is your cattle have convulsion?',
    'is your cattle have red urine?',
    'is your cattle inappitance?',
    'is your cattle septicemia?',
    'is your cattle generalized oedema(mostly around dewalp)?',
    'is your cattle have anorexia?',
    'is your cattle have cough?',
    'is your cattle have shortness of breath?',
    'is your cattle have mucopurulent nasal discharge?',
    'is your cattle have ataxia?',
    'is your cattle have eye blinking?',
    'is your cattle have jugular pulsation?',
    'is your cattle have lameness?',
    'is your cattle have muscle tremor?',
    'is your cattle have tachypnea?',
    'is your cattle have anemia?',
    'is your cattle have melena(blood in feces)?',
    'is your cattle shows nervous sign?',
    'is your cattle have diarrhea?',
    'is your cattle have depression?',
    'is you cattle sub-mandibular oedema?',
    'is you cattle unable to stand?',
    'is you cattle have sternal recumbency?',
    'is your cattle milk production is decrease?'
  ];

  var answer1 = ['Adult(>6)', 'Male', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes',
    'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes',
    'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'Yes', 'yes'];

  var answer2 = ['young(0-6)', 'Female', 'No', 'No', 'No', 'No', 'No',
    'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No',
    'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No', 'No'];

  List<String> ans = [];

  List<String> Temp = [];
  List<String> Rumination = [];
  List<String> lati = [];
  List<String> long = [];
  List<String> heartbeat = [];
  List<String> serialCode = [];
  List<String> timeDate = [];

  List<String> Tempday = [];
  List<String> Ruminationday = [];
  List<String> Heartbeatday = [];

  List<double> fTemp = [];
  List<double> frum = [];
  List<double> fheart = [];

  String Tempneed;
  String Rumineed;
  String Heartneed;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eyu();
    NotificationApi.init();
    Future.delayed(Duration.zero, () {
      retriveDataAll();
    });

  }

  void eyu() {
    if (Tempneed == null && Rumineed == null && Heartneed ==null){
      Tempneed = '0';
      Rumineed = '0';
      Heartneed = '0';
      fTemp = [0,0,0,0,0,0,0];
      fheart = [0,0,0,0,0,0,0];
      frum = [0,0,0,0,0,0,0];
    };
  }

  final dref = FirebaseDatabase.instance.reference().child('date').orderByChild('Time_and_Date');

  void writeData() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime
    // Database” step with DatabaseURL
    var url = "https://hearty-project-default-rtdb.firebaseio.com/"+"data.json";

    // (Do not remove “data.json”,keep it as it is)
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          "temperature": '38.5',
        "rumination" : '450',
        "heartbeat" : '49',
        "serial_code" : '5Bg3562bh',
        "latitude" : '37.846732891',
        'longitude': '7.26739402781',
        'TimeDate' : '04/10/2020'}),
      );
    } catch (error) {
      throw error;
    }
  }

  retriveData (){
    dref.once().then((data){
      Map<dynamic, dynamic> eyumar = data.snapshot.value;
      var TimeDate = eyumar['Test']['temperature'];
      print(TimeDate);
    });
  }

  bool isLoading = true;
  bool isgetting = false;

  retriveDataAll() async {
    // Please replace the Database URL
    // which we will get in “Add Realtime Database”
    // step with DatabaseURL
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

    var url = "https://hearty-project-default-rtdb.firebaseio.com/"+"data.json";
    // Do not remove “data.json”,keep it as it is
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      Temp.clear();
      heartbeat.clear();
      serialCode.clear();
      Rumination.clear();
      timeDate.clear();
      extractedData.forEach((blogId, blogData) {
        if (serial == blogData["Serial_Code"]){
          Temp.add(blogData["Temperature"]);
          heartbeat.add(blogData["Heartbeat"]);
          serialCode.add(blogData["Serial_code"]);
          Rumination.add(blogData["Rumination"]);
          timeDate.add(blogData["Date_and_Time"]);
        };
      });
      setState(() {
        isLoading = false;
        print('Temp : ${Temp}');
        print('Rumin : ${Rumination}');
        print('heartbeat : ${heartbeat}');
        isgetting = true;
        Tempneed = Temp[Temp.length - 1];
        Rumineed = Rumination[Rumination.length - 1];
        Heartneed = heartbeat[heartbeat.length - 1];

        if (double.parse(Temp[Temp.length - 1]) > 40.4){
          NotificationApi.showNotification(
            title: 'Alert Message',
            body: 'Hey! sir please check your cattle disease prediction '
                'Because your cattle Temperature is more than > 40.5',
            payload: 'sarah.abs',
          );
          print('yes i am here');
        }
        _arrange('Days');
      });
      Navigator.of(context).pop();
    } catch (error) {
      Navigator.of(context).pop();
      throw error;
    }
  }

  void _arrange (selectedItem){
    print('yesyesyes');
    if (selectedItem == 'Days') {
      if (Temp.length > 3){
        setState(() {
          Tempday = Temp.sublist((Temp.length - 3), Temp.length);
          Ruminationday = Rumination.sublist((Rumination.length - 3), Rumination.length);
          Heartbeatday = heartbeat.sublist((heartbeat.length - 3), heartbeat.length);
          print('Temp ${Tempday}');
        });
      }
      else {
        setState(() {
          Tempday = Temp;
          Ruminationday = Rumination;
          Heartbeatday= heartbeat;
          print('eyu ${Tempday}');
        });
      }
    }
    else if (selectedItem == 'Weekly') {
      if (Temp.length > 21)
      setState(() {
        Tempday = Temp.sublist((Temp.length-21), Temp.length);
        Ruminationday = Rumination.sublist((Rumination.length - 21), Rumination.length);
        Heartbeatday = heartbeat.sublist((heartbeat.length - 21), heartbeat.length);
        print('Temp week ${Tempday}');
      });
      else{
        setState(() {
          Tempday = Temp;
          Ruminationday = Rumination;
          Heartbeatday = heartbeat;
          print('eyu week ${Temp}');
        });
      }
    }
    else{
      if (Temp.length > 90) {
        setState(() {
          Tempday = Temp.sublist((Temp.length - 90), Temp.length);
          Ruminationday = Rumination.sublist((Rumination.length - 90), Rumination.length);
          Heartbeatday = heartbeat.sublist((heartbeat.length - 90), heartbeat.length);
          print('Temp Month ${Tempday}');
        });
      }
      else{
        setState(() {
          Tempday = Temp;
          Ruminationday = Rumination;
          Heartbeatday = heartbeat;
          print('eyu month ${Temp}');
        });
      }
    }
    setState(() {
      fTemp.clear();
      frum.clear();
      fheart.clear();
      for (int i = 0; i < Tempday.length; i++){
        fTemp.add(double.parse(Tempday[i]));
        frum.add(double.parse(Ruminationday[i]));
        fheart.add(double.parse(Heartbeatday[i]));
      }
    });
    //print(fTemp);
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;

  List<String> progress = ['Days', 'Weekly', 'Monthly'];
  String selectedItem = 'Days';
  var data = [0.0, 0.1, 0.2, 0.4, 0.3, 0.5];

  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    final text = MediaQuery.of(context).platformBrightness == Brightness.dark?
    'DarkTheme' : 'LightTheme';

    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'message_57'),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Sensor data getten',
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
                                onChanged: (prog) => setState(() {
                                  selectedItem = prog;
                                  _arrange(selectedItem);
                                })),
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
                          child: new Sparkline(data: fTemp != null? fTemp: data,
                          fillMode: FillMode.below,
                          fillGradient: new LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.amber[800], Colors.amber[200]]
                          ),)

                        ),
                        Padding(padding: const EdgeInsets.all(10),
                          child: Text(
                            getTranslated(context, 'message_69') + ' = $Tempneed', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        )
                      ],
                    ),
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
                          child: new Sparkline(data: fheart != null ? fheart : data,
                            fillMode: FillMode.below,
                            fillGradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.amber[800], Colors.amber[200]]
                            ),)
                        ),
                        Padding(padding: const EdgeInsets.all(10),
                          child: Text(
                            getTranslated(context, 'message_81') + ' = ${Heartneed}', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(height: 15,),

                  Container(
                    width: MediaQuery.of(context).size.width*0.9,
                    height: 150,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: Temp != null ? Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.9,
                          child: new Sparkline(data: frum != null ? frum :data,
                            fillMode: FillMode.below,
                            fillGradient: new LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.topCenter,
                                colors: [Colors.amber[800], Colors.amber[200]]
                            ),)
                        ),
                        Padding(padding: const EdgeInsets.all(10),
                          child: Text(
                            getTranslated(context, 'message_82') + ' = $Rumineed', style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                        )
                      ],
                    ):Container(),
                  ),

                  SizedBox(height: 15,),

                  ElevatedButton(
                    onPressed: () => openDialog(),
                    child: Text(getTranslated(context, 'message_51'),
                      style: TextStyle(fontSize: 20),),
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      side: BorderSide(width: 2, color: Colors.greenAccent),
                      shape: RoundedRectangleBorder( //to set border radius to button
                          borderRadius: BorderRadius.circular(30)
                      ),
                    ),),
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

                ],
            ),
        )
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Expert System'),
        content: Text(questions[questionIndex]),
        backgroundColor: Colors.blueGrey,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: [
          TextButton(
              onPressed: (){
                questionIndex = 0;
                ans.clear();
                Navigator.push(context, MaterialPageRoute(builder: (context) => securityCode()),);
              },
              child: Text('Clear')),
          TextButton(
            child: Text(answer1[questionIndex]),
            onPressed: () {
              ans.add('1.');
              questionIndex += 1;
              if (questionIndex == 2){
                ans.add((double.parse(Tempneed)/46.67).toString());
                ans.add((double.parse(Heartneed)/89.9).toString());
                if(double.parse(Rumineed) < 300){
                  ans.add('1.');
                }else{
                  ans.add('0.');
                }
                print(ans);
                openDialog();
              }
              else if (questionIndex < questions.length){
                openDialog();
              }
              else {
                print(ans);
                if (ans.length == 32){
                  Map <String, List> ans1 = {"values" : ans};
                  String answer = jsonEncode(ans1);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => resultDisplay(answer)),);}
                else{
                  print('the data is not full fill');
                }
              }
            },
          ),
          TextButton(
            child: Text(answer2[questionIndex]),
            onPressed: () {
              ans.add('0.');
              questionIndex += 1;
              if (questionIndex == 2){
                ans.add((double.parse(Tempneed)/46.67).toString());
                ans.add((double.parse(Heartneed)/89.9).toString());
                if(double.parse(Rumineed) < 300){
                  ans.add('1.');
                }else{
                  ans.add('0.');
                }
                print(ans);
                openDialog();
              }
              else if (questionIndex < questions.length){
                openDialog();
                print(ans);
              }
              else{
                print(ans);
                if (ans.length == 32){
                  Map <String, List> ans1 = {"values" : ans};
                  String answer = jsonEncode(ans1);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => resultDisplay(answer)),);}
                else{
                  print('the data is not full fill');
                }
              }
            },
          )
        ],
      ));
}