import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hearty/Splash/widgets/header_widget.dart';
import 'package:hearty/hearty%20function/Security_code.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class resultDisplay extends StatefulWidget {
  final String answer;
  const resultDisplay(this.answer, {Key key}) : super(key: key);

  @override
  State<resultDisplay> createState() => _resultDisplayState(this.answer);
}

class _resultDisplayState extends State<resultDisplay> {
  final String answer;
  _resultDisplayState(this.answer);

  bool isClicked = false;
  bool isDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      getresponse(answer);
    });
  }

  var eyu;

  void getresponse(answer)async{

    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });

    final headers = <String, String>{"Accept":"application/json"};

    print(answer);
    var response = await http.post(Uri.parse('https://cattle-flask-disease.herokuapp.com'), body: answer, headers: headers);
    print(response);
    var pdfText= await json.decode(response.body);
    setState(() {
      eyu =  pdfText['results']['results'];
    });
    print(eyu);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result of diagnosis'),
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => securityCode()),);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
          Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
            SizedBox(height: 15,),
          Text('The Tentative Result : ', textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),),
          SizedBox(height: 20,),
            eyu != null ?Text(eyu, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,)): Container(),
            SizedBox(height: 20,),
            Text('Treatment and Meditation ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),

            SizedBox(height: 14,),
            (eyu == "Normal")
                ? Text(
                "The Cattle is Normal please if you have doubt check other disease in your nearest laboratory. \n",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17)):
               (eyu == 'trypanosomsis') ? Container(
              child: Column(
                children: [
                  Text(
                      "Drug and prepartions", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)
                  ),
                  SizedBox(height: 14,),
                  Text('1. Diminazene aceturate',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('- Prepartion : 1.05 g sachet dissolved in 10 ml of sterile distilled water',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('2. Homidium (Ethidium bromide) and Homidium chloride (Novidium chloride)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('- Prepartion : 250 mg tablets',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('3. Isometamidium (samorin) prothidium ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('- Prepartion : 1g or 125mg sachet',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('4. Quinapyramine sulfate (Antrycide sulfate) or Quinapymine (Antrycide prosalt)',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: 14,),
                  Text('- Prepartion : 1gram powder',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                ],
              ),
            ): (eyu == 'Anthrax') ? Column(
              children: [
                Text('- Often the first signs of anthrax infection are the death of cattle, '
                    'which makes it challenging to know that treatment is necessary. In some cases, '
                    'high doses of penicillin have been used effectively. Inhalation anthrax can be '
                    'treated using antibiotics',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 17)),
                SizedBox(height: 14,),
              ],
            ) : (eyu == 'Pnenumanic') ?
                Column(
                  children: [
                    Text('Non-drug treatment', style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center),
                    SizedBox(height : 14),
                    Text('- The treatment of pneumonia depends on the etiology',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Nursing: sick animals should be provided with shelter, animals should be given good quality long-stem pasture.',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height: 17,),
                    Text('Drug treatment', style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center),
                    SizedBox(height : 14),
                    Text('- sulfamethazine initial 220 mg/kg; Maintenance110 mg/kg q 24 h PO for 5-7days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Procaine penicillin G, 22000 1U/kg, aqueous suspension, 1M or SC q 24hr for 3-5days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Ampicillin trihydrate 22 mg/kg, 1M Sc 1 24hr for 3-6days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Amoxicillin trihydrate 11 mg/kg, 1M, SC q 24hr for 3-7days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Oxytetracyline hydrochloride 11 mg/kg, SC, q 24 hr or long acting formulation, 20 mg/kg, Sc, q 48hr for 3-5 days.',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Tylosin 44 mg/kg, 1M q 24hr for 3-5days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height: 17,),
                    Text('2. For Aspiration pneumonia', style: TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center,),
                    SizedBox(height : 14),
                    Text('2.1 Tylosin 11 mg/kg, 1M, q 8h for 3 days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('2.2 Oxytetracycline 15 mg/kg, 1M, q 12 h, for 3-5days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('2.3 Chloramphenical 22 mg/kg, 1M, q 12 h, for 3-5days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height: 17,),
                    Text('Prophylaxis:- Vaccination', textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 17)),
                    SizedBox(height: 17,),
                    Text('3. For Enzootic pneumonia', style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center),
                    SizedBox(height: 14,),
                    Text('Symptom:- Fever, pneumonia, lethargy and dyspnea and with a serous '
                        'and later mucopurulent nasal discharge and a dry hacking cough',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('3.1 Oxytetracycline 25-50 mg/kg, q 24 h for 5-7days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('3.2 Penicillin 20,000 to 40,000 1UKg, q 24 h for 4-5 days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('3.3 Ampicillin 4-10 mg/kg, q 12 h, for 4-5days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('3.4 tylosin 11 mg/kg, 1M q 8h for 3 days',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height: 17,),
                  ],
                ) : (eyu == 'cowdrosis') ?
                Column(
                  children: [
                    Text('First line', style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold
                    ),textAlign: TextAlign.center),
                    SizedBox(height : 14),
                    Text('- Oxytetracycline 10 mg/kg 1v. q 12-24 hr long acting formulation. q 48-72hr times',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 14),
                    Text('- Doxycycline 2mg/Kg q 24 h. 1V ',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    ),
                    SizedBox(height : 17),
                    Text('- Prophylaxis :- Tick control but maintain enzootic stability',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 17)
                    )
                  ],
                ):
            (eyu == 'black leg') ?
                Column(
                  children: [
                    Text('Non-drug treatment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text(
                      '- Drainage and slashing of affected tissue to allow oxygen into the '
                          'tissue plus supportive treatment with parenteral fluids, analgestic, etc...',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Drug treatment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Procaine Penicillin G. 22,000 1U/kg, 1M or SC q 24 hr for 3-5 Days',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Benzathine penicillin or similar repository preparations. q 48-72 hr.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Plus',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Local antibiotic treatment eg. Oxytetracycline spray 5% at the site of the wound is helpful',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Prevention',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Vaccination with C. chauvoei bacterin.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ):
            (eyu == 'dictyocaulosis')? Column(
              children: [
                Text('Drug treatment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                SizedBox(height: 14,),
                Text('- Levamectin: Ivermectin and levamisole. 0.4-0.6 ml / 10 kg. Used for dictyocaulosis of heifers.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('- Rytril. Used to treat young cattle. Dose 0.8 ml / 10 kg, intramuscularly.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('- Praziver, the active ingredient is ivermectin. 0.2 mg / kg.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('- Monezin. Adult cattle 0.7 ml / 10 kg orally, once.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('- Ivomek. For young cattle 0.2 mg / kg.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('- Eprimectin 1%.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
              ],
            ) :
            (eyu == 'babesiosis') ?
                Column(
                  children: [
                    Text('Drug treatment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Diminazene aceturate at the dose rate of 3.5 mg/kg. its deep intramuscular Alternative days',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Imidocarb at the dose rate of 1.2 mg/kg. Subcutaneous route',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Long acting injection, Oxytetracycline at the dose rate of 6.6-11 mg/kg Deep intramuscular Alternative days',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Plane injection Oxytetracycline at the dose rate of 6.6-11mg/kg. Along with DNS intravenous route daily for 5days',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- For anemia recovery, injection Ferritas, Deep intramuscular Alternative days injection inferon 10ml per day and blood transfusion',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Therapy like injection. Meloxicam at the dose rate of 0.5mg/kg Intramuscular, injection'
                        '. Chlorphenaramine meliate at the dose rate of 0.5 mg/kg Intramuscular, corticosteroid, fluid therapy',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Oral supplementation of Iron preparations 25-50ml per day',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ):
            (eyu == 'salmonellosis')?Column(
              children: [
                Text('Non-drug treatment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                SizedBox(height: 14,),
                Text('good nursing rate, good hygiene, and if possible, separation of the sick form healthy animals.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,),
                SizedBox(height: 17,),
                Text('Drug treatment',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                SizedBox(height: 14,),
                Text('Gentamicin 3.5 mg/kg, 1M, q 8h for 3-5 days.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('Trimethoprim-sulfadiazine 30 mg/kg, PO for 3-5 days.',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('Ampicillin 15 mg/kg q12 h, 1M or 25 mg/kg PO (calves) for 3-5 days',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 14,),
                Text('Enrofloxacin 5mg/kg. SC. q 24 h for 3-5 days',
                  style: TextStyle(fontSize: 17),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: 17,),
                Text('Prophylaxis:- Carrier animals should be isolated and culled or'
                    'treated vigorously. Recheck animals several times, clean'
                    'contaminated buildings, dispose contaminated materials '
                    'and minimize stress in outbreaks.')
              ],
            ):
            (eyu == 'Fasciolosis') ?
                Column(
                  children: [
                    Text('First line', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Triclabendazole 9-12 mg/kg. PO stat (all stages of fasciola). '
                        'S/E: Higher doses are associated with inappetence increased blood urea nitrogen, transient weight loss and slight effect on '
                      'motor activities.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,),
                    SizedBox(height: 14,),
                    Text('second line', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Rafoxanide 7.5 mg/kg. PO, stat against flukes above 4 week old and most nematodes. '
                        'S/E: At high does inappetence, diarrhea and blindness may occur. '
                        'D/F: Rafoxanide is available at 2.5%, 7.5 ml/50g'
                        'W/P: meat 28days milk cows should not be treated with Rafoxanide',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,),
                    SizedBox(height: 14,),
                    Text('- Albendazole 10 mg/kg. PO.stat. S/E: generally it is well tolerated. itis embryotoxic at two times the recommended doses. '
                        'limiting its use in pregnant animals particularly the first 45 days of gestation. Hypersensitivity to albendazole may occur.',
                    style: TextStyle(fontSize: 17),
                    textAlign: TextAlign.start,)
                  ],
                ): (eyu == 'Hypocalcemia') ?
                Column(
                  children: [
                    Text('Drug treatment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Calcium borogluconate signal 1V dose of between 8 and 10g ca, 400ml of 40% solution will give 12g of available Ca. '
                        'The drug is infused within 5 to 10 minutes. it may also be concurrently adiministered SC',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Maintenance',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Propylene glycol 125 - 250 g PO q 12 h mixed with an equal volume of water prevent relapse',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Plus',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Calcium borogluconate as above. '
                        'S/E Excessive amount of calcium salts may lead to hypercalcemia.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('precaution',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Store in a controlled temprature at 15-30 degree celius. Caution follow strict sterile procedures',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    Text('Prevention',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- During the dry period, maintain low level Calcium in feed (< 50 Ca/day), supply Mg (>50 g per day).prevention',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ) :
            (eyu == 'Leptospiriosis')?
                Column(
                  children: [
                    Text('Drug Treatment',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('- Tetracycline 10-15 mg/kg, 1M, q 12h, for 3-5 days.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Streptomycin 12.5 mg/kg, 1M q 12h. for 3 days',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 14,),
                    Text('- Streptomycin can be combined with amplicillin or large doses of procaine penicillin G, 1M.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: 17,),
                    Text('Control and Prophylaxis',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic)),
                    SizedBox(height: 14,),
                    Text('-  Direct contact with carriers or rodents should be avoided vaccination for the most endemic Serovar.',
                      style: TextStyle(fontSize: 17),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ) : Container()
        ]),
      ),
    );
  }
}
