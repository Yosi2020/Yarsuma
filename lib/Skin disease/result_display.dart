import 'dart:io';
import 'package:tflite/tflite.dart';
import 'package:flutter/material.dart';
import 'package:hearty/Skin%20disease/skin_disease.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';

class reultSkin extends StatefulWidget {
  final File image;
  const reultSkin(this.image, {Key key}) : super(key: key);

  @override
  State<reultSkin> createState() => _reultSkinState(this.image);
}

class _reultSkinState extends State<reultSkin> {

  final File image;
  _reultSkinState(this.image);

  List _output;
  String eyosi;
  bool isDone = false;

  @override
  void initState(){
    super.initState();
    loadModel().then((value) => setState((){
    }));
    dectectImage(image);
  }

  dectectImage(File image) async{
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults:3,
        threshold: 0.4,
        imageMean: 127.5,
        imageStd: 127.5
    );
    setState(() {
      _output = output;
      eyosi = _output[0]['label'];
      isDone = true;
      print(eyosi);
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Result Display'),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => SkinDisease()),);
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: [
                  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
                  SizedBox(height: 10,),
                  Image.file(
                    image, width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height/3.4,
                  ),
                  SizedBox(height: 10,),
                  Text('The Tentative Result : ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                  Divider(),
                  Text('${eyosi}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)),
                  SizedBox(height: 20,),
                  eyosi == 'Not Cattle Skin'? Text('Please Your image is not cattle skin, try again by adding the cattle skin.', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),) :
                  eyosi == 'Normal' ?
                  Text('Your cattle is Normal please check other one please', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),) :
                  Text('Treatment and Medication', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),

                  eyosi == 'Ringworm Disease' ? Column(
                    children: [
                      Text(' - Dermatophytosis is a self-curing disease in most animals In animals that are treated, a systemic antifungal drug will '
                          'eliminate active infection in hair follicles Animals can be treated to shorten the course of the disease and minimize '
                          'contagion to other susceptible animals or people. Infected small animals should be kept isolated from other pets until '
                          'there is clear evidence of clinical cure. Young animals should not be overly confined or undersocialized, or lifelong '
                          'behavioral problems may occur.', style: TextStyle(fontSize: 17),textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Adjunct focal topical therapy can be used for lesions in hard-to-treat locations such as the ears and face. A 1%–2% vaginal '
                          'miconazole cream can safely be used on the face. For the ears, otic products that contain clotrimazole or miconazole/chlorhexidine '
                          'or ketoconazole/chlorhexidine combinations are available.', style: TextStyle(fontSize: 17),textAlign: TextAlign.start,),
                    ],
                  )
                   :
                  eyosi == 'Lumpy Disease' ? Column(
                    children: [
                      Text('First Preparation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                      SizedBox(height: 14,),
                      Text('Ingredients: (For one dose)', style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                      SizedBox(height: 17,),
                      Text(' - Preparation ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Blend to form a paste and mix with jaggery', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed the dose in small portions orally', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed one dose every three hours for the first day(Day 1)', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed three dose daily from the second day onwards for 2 weeks (Day 2 onwards)', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 17,),
                      Text('Second Preparation', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                      SizedBox(height: 14,),
                      Text('Ingredients: (For 2 dose)', style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                      SizedBox(height: 14,),
                      Text('Garlic -2 pearls; Corlander - 10g, Cumin - 10g, Tulsi -1 handful; Dry cinnamon leaves - 10g;'
                          'Black pepper - 10g; Betel leaves - 5nos; shallots - 2 bulbs; Turmeric powder - 10g; Chirata leaf powder - 30 g;'
                          'Sweet basil - 1 handful; Neem leaves - 1  handful; Aegle marmalos (Bel) leaves -1 handful; jaggery - 100g',
                        style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                      SizedBox(height: 14,),
                      Text(' - Preparation ', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed the dose in small portions orally', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed one dose every three hours for the first day(Day 1)', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 14,),
                      Text(' - Feed two dose daily in the morning and evening from the second day till condition resolves (2 day onwards)',
                        style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                      SizedBox(height: 17,),

                      Text('For External Application (if there are wounds)', style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                      SizedBox(height: 14,),
                      Text('Acalypha indica leaves - 1 handful; Garlic -10 pearls; Neem leaves - 1 handful; Coconut or Sesame oil - 500ml;'
                          ' Turmeric powder - 20g; Mehndi leaves -1 handful; Tulsi leaves - 1 handful.',
                        style: TextStyle(fontSize: 17), textAlign: TextAlign.center,),
                      SizedBox(height: 14,),
                    ],
                  )
                   :
                  eyosi == 'Papilloma Disease' ?Column(
                        children: [
                          Text('Drug that are effectively treat 88-100%',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
                          SizedBox(height: 14,),
                          Text(' - Ivermectin at a dose of 0.2 mg/kg body weight twice with two weeks interval subcutaneously '
                              'aіer largersized and older nodules were removed by manual excision and topicalantiseptic application.',
                            style: TextStyle(fontSize: 17), textAlign: TextAlign.start)
                        ],
                      )
                       :
                  eyosi == 'Photosensitization Disease' ? Column(
                            children: [
                              Text(' - Intravenous fluids if there is depression and shock. Soothing ointments can be applied to raw areas '
                                  'to help prevent itching and pain, and prevent infection', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                              SizedBox(height: 14,),
                              Text(' - Removal to cool shaded housing', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                              SizedBox(height: 14,),
                              Text(' - Fly control', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                              SizedBox(height: 14,),
                              Text(' - Supportive therapy', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),
                              SizedBox(height: 14,),
                              Text(' - Treatment of liver failure (if present)', style: TextStyle(fontSize: 17), textAlign: TextAlign.start,),

                            ],
                          )
                          :
                              Container(),
                ]))
    );
  }

}
