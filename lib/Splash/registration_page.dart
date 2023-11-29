import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hearty/Splash/login_page.dart';
import 'package:hearty/hearty%20function/bottom%20navigator.dart';
import 'widgets/theme_helper.dart';
import 'widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:hearty/classes/language.dart';
import 'package:hearty/localization/language_constants.dart';
import 'package:hearty/main.dart';

class RegistrationPage extends  StatefulWidget{

  User get user => FirebaseAuth.instance.currentUser;
  Stream<User> get authState => FirebaseAuth.instance.authStateChanges();

  @override
  State<StatefulWidget> createState() {
    return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  String First_name = '';
  String last_name = '';
  String email_name = '';
  String mobile_number = '';
  String password = '';
  String config_password = '';

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Image.asset('assets/image/logo.png', height: 80, width: 80,)
                              ),
                              //Container(
                              //  padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                               // child: Icon(
                                //  Icons.add_circle,
                                 // color: Colors.grey.shade700,
                                  //size: 25.0,
                                //),
                              //),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(getTranslated(context, 'message_19'), getTranslated(context, 'message_20')),
                            onChanged: (value) => setState(() => First_name = value),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(getTranslated(context, 'message_21'), getTranslated(context, 'message_22')),
                            onChanged: (value) => setState(() => last_name = value),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(getTranslated(context, 'message_23'), getTranslated(context, 'message_24')),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) => setState(() => email_name = value),
                            validator: (val) {
                              if(!(val.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            decoration: ThemeHelper().textInputDecoration(
                                getTranslated(context, 'message_25'),
                                getTranslated(context, 'message_26')),
                            keyboardType: TextInputType.phone,
                            validator: (val) {
                              if(!(val.isEmpty) && !RegExp(r"^(\d+)*$").hasMatch(val)){
                                return "Enter a valid phone number";
                              }
                              return null;
                            },
                            onChanged: (value) => setState(() => mobile_number = value),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: isHiddenPassword,
                            onChanged: (value) => setState(() => password = value),
                            decoration: InputDecoration(
                                labelText: getTranslated(context, 'message_27'),
                                hintText: getTranslated(context, 'message_28'),
                                fillColor: Colors.white10,
                                filled: true,
                                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                                suffixIcon: InkWell(
                                  onTap: _togglePassword,
                                  child:isHiddenPassword ? Icon(
                                    Icons.visibility,
                                  ): Icon(Icons.visibility_off),
                                ),),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            obscureText: isHiddenPassword1,
                            onChanged: (value) => setState(() => password = value),
                            decoration: InputDecoration(
                              labelText: getTranslated(context, 'message_29'),
                              hintText: getTranslated(context, 'message_30'),
                              fillColor: Colors.white10,
                              filled: true,
                              contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey)),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.grey.shade400)),
                              errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                              focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(100.0), borderSide: BorderSide(color: Colors.red, width: 2.0)),
                              suffixIcon: InkWell(
                                onTap: _togglePassword1,
                                child:isHiddenPassword1 ? Icon(
                                  Icons.visibility,
                                ): Icon(Icons.visibility_off),
                              ),),
                            validator: (val) {
                              if (val.isEmpty) {
                                return "Please enter your password";
                              }
                              else if (config_password == password) {
                                return "your password didn't match please re write again!";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text(getTranslated(context, 'message_31'), style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                getTranslated(context, 'message_32'),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                create();
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30.0),
                        Text(getTranslated(context, 'message_33'),  style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 35,
                                color: HexColor("#EC2D2F"),),
                              onTap: () => signInWithGoogle(context)
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 35,
                                color: HexColor("#3E529C"),),
                              onTap: () async {
                                await signInWithFacebook(context);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FACEBOOK SIGN IN
  Future<void> signInWithFacebook(BuildContext context) async {
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    try {
      debugPrint('Eyu i am here up');
      final LoginResult loginResult = await FacebookAuth.instance.login();

      debugPrint('Eyu i am here');
      final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken.token);
      debugPrint('Eyu i am here getting token '+ loginResult.toString());
      (await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential)).user;
      Navigator.of(context).pop();
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MyBottomBarDemo())
      );
      debugPrint('Eyu i am here finishing uploading to firebase');
    } on FirebaseAuthException catch (e) {
      debugPrint("Message  "+e.message);
      Navigator.of(context).pop();
      _showAlertDialogerror("Hearty Yasuma Device and Software",
          e.message.toString());// Displaying the error message
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async{
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    try{
      debugPrint('Eyu i am here up');
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      debugPrint('Eyu i am here SignIn read');

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;
      debugPrint('Eyu i am here authentication');

      if (googleAuth.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        debugPrint('Eyu i am here getting token');
        UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pop();
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MyBottomBarDemo())
        );
        debugPrint('Eyu i am uploading to firebase');
        // if you want to add your filling info into firestore.
        //if (userCredential.user != null){
          //if (userCredential.additionalUserInfo.isNewUser){ }
        //}
      }
    } on FirebaseAuthException catch(e) {
      debugPrint(e.message);
      Navigator.of(context).pop();
      _showAlertDialogerror("Hearty Yasuma Device and Software",
          e.message.toString());
    }
    //Navigator.of(context).pop();
  }

  bool isHiddenPassword = true;
  void _togglePassword(){
    if(isHiddenPassword == true){
      isHiddenPassword = false;
    }
    else isHiddenPassword = true;
    setState(() {
      isHiddenPassword = isHiddenPassword;
    });
  }

  bool isHiddenPassword1 = true;
  void _togglePassword1(){
    if(isHiddenPassword1 == true){
      isHiddenPassword1 = false;
    }
    else isHiddenPassword1 = true;
    setState(() {
      isHiddenPassword1 = isHiddenPassword1;
    });
  }

  void create() {
    String FirstName = First_name.trim();
    String LastName = last_name.trim();
    String Email = email_name.trim();
    String Password = password.trim();
    String Mobile = mobile_number.trim();
    register(FirstName, LastName, Email, Password, Mobile);
  }
  final CollectionReference collectionRef =
  FirebaseFirestore.instance.collection("Create_Account");

  Future<void> register(String FirstName, LastName, Email, Password, Mobile) async {
    showDialog(
        context: context, builder: (context){
      return Center(child: CircularProgressIndicator(),);
    });
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email, password: Password)
        .then((value) => {
      postDetialToFirebase(FirstName, LastName, Email, Password, Mobile)})
        .catchError((error) => _showAlertDialogerror("Hearty Yasuma Device and Software",
        error.message.toString()));
    //_showAlertDialog("Image Data Collection for AI",
    //  "Problem on sending Your request, please try again."));
  }
  postDetialToFirebase(FirstName, LastName, Email, Password, Mobile) async{
    await printDocID();
    return collectionRef.add(
      {'First Name': FirstName,
        "Last Name": LastName,
        "Email": Email,
        "Password": Password,
      "Mobile": Mobile},
    ).then((eyu) =>  _showAlertDialog("Hearty Yasuma Device and Software",
        "Your request send Successfully. You can login"))
        .catchError((error) =>
        _showAlertDialog("Hearty Yasuma Device and Software",
            "Problem on sending Your request, please try again."));
  }

  printDocID() async {
    var querySnapshots = await collectionRef.get();
    for (var snapshot in querySnapshots.docs) {
      var documentID = snapshot.id;
      debugPrint(documentID);
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new TextButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginPage())
              );
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }

  void _showAlertDialogerror(String title, String message){
    AlertDialog alertDialog = AlertDialog(
        title: Text(title),
        content: Text(message),
        backgroundColor: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
        actions: <Widget>[
          new TextButton(
            child: Text('Exit'),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => RegistrationPage())
              );
            },
          ),
        ]
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog);
  }
}