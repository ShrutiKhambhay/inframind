import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trackhealth/screens/healthbot.dart';
import 'package:trackhealth/services/api_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer2/mailer.dart';

void main() => runApp(HomeScreen());

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const routeName = '/home';
}

class _HomeScreenState extends State<HomeScreen> {
  final API_Manager apivalue = API_Manager();
  final Fireinstance = FirebaseFirestore.instance;
  final User = FirebaseAuth.instance.currentUser;
  double avgbodytemperature = 0;
  int avgbloodpressure = 0;
  int avgrespiratory = 0;
  int avgheartrate = 0;
  int avgcholesterol = 0;
  int avgglucose = 0;
  int avgoxygensaturation = 0;
  int c = 0;
  FToast fToast;
  Mail() async {
    var top = new GmailSmtpOptions()
      ..username = 'fvscode@gmail.com'
      ..password = '';
    var emailTransport = new SmtpTransport(top);
    var envelop = new Envelope()
      ..from = 'fvscode@gmail.com'
      ..recipients.add('snkhambhay777@gmail.com') //recipent email
      ..ccRecipients.addAll(
          ['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
      ..subject =
          'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'; //subject of the email
    emailTransport.send(envelop).then((envelope) {
      print('Email sent!');
      emailToast("Email Sent!");
    }).catchError((e) => print('Email Error occurred: $e'));
  }

  emailToast(emailtoasttext) {
    if (emailtoasttext == "Sending Health Report") {
      //icon=Icon(Icons.timelapse);
      //color=Colors.lightBlueAccent;
    } else if (emailtoasttext == "Email Sent!") {
      //icon=Icon(Icons.check);
      //color=Colors.lightGreenAccent;
    }
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        //color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.CENTER,
      toastDuration: Duration(seconds: 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Health Track App'),
          backgroundColor: Color(0xff8a0a3d),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xff8a0a3d),
          child: const Icon(Icons.chat),
          onPressed: () {
            _navigateToNextScreen(context);
          },
        ),
        body: FutureBuilder(
            future: apivalue.getInfo(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var healthvalue = snapshot.data;
                //getdataperiodic(healthvalue) {
                Timer.periodic(Duration(seconds: 30), (timer) {
                  Fireinstance.collection('data').add(
                    {
                      "bodytemperature": healthvalue.bodyTemperature,
                      "bloodpressure": healthvalue.bloodPressure,
                      "respiratoryrate": healthvalue.respiration,
                      "heartrate": healthvalue.heartRate,
                      "cholesterol": healthvalue.cholestrol,
                      "glucose": healthvalue.glucose,
                      "öxygensaturation": healthvalue.oxygensaturation,
                      "uid": User.uid,
                    },
                  );
                });
                // }

                Fireinstance.collection("data")
                    .get()
                    .then((QuerySnapshot querySnapshot) => {
                          querySnapshot.docs.forEach((doc) {
                            avgbodytemperature =
                                avgbodytemperature + doc["bodytemperature"];
                            avgbloodpressure =
                                avgbloodpressure + doc["bloodpressure"];
                            avgrespiratory =
                                avgrespiratory + doc["respiratory"];
                            avgheartrate = avgheartrate + doc["heartrate"];
                            avgcholesterol =
                                avgcholesterol + doc["cholesterol"];
                            avgglucose = avgglucose + doc["glucose"];
                            avgoxygensaturation =
                                avgoxygensaturation + doc["oxygensaturation"];
                            c++;
                          }),
                          {
                            avgbodytemperature = (avgbodytemperature / c),
                            avgbloodpressure = (avgbloodpressure ~/ c),
                            avgrespiratory = (avgrespiratory ~/ c),
                            avgheartrate = (avgheartrate ~/ c),
                            avgcholesterol = (avgcholesterol ~/ c),
                            avgglucose = (avgglucose ~/ c),
                            avgoxygensaturation = (avgoxygensaturation ~/ c),
                            print('$avgbodytemperature'),
                            print('$avgbloodpressure'),
                            print('$avgrespiratory'),
                            print('$avgheartrate'),
                            print('$avgglucose'),
                            print('$avgoxygensaturation'),
                            Mail(),
                          }
                        });

                return Container(
                    margin: EdgeInsets.only(
                        left: 30, top: 70, right: 30, bottom: 50),
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Container(
                        alignment: FractionalOffset.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              'Body Temperature:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.bodyTemperature.toString() +
                                  ' degree C',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'BloodPressure:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.bloodPressure.toString() + ' mmHg',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Respiratory Rate:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.respiration.toString() +
                                  ' breaths per minute',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Heart Rate:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(color: Colors.black),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              snapshot.data.heartRate.toString() +
                                  ' beats per minute',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Cholesterol:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.cholestrol.toString() + ' mg',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Glucose:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.glucose.toString() + ' mmol/L',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              'Oxygen Saturation:',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              snapshot.data.oxygensaturation.toString() + ' %',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        )));
              }
              return Center(child: CircularProgressIndicator());
            }));
  }

  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => HealthBot()));
  }
}
