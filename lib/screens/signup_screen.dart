import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupScreen extends StatefulWidget {
  static const routeName = '/signup';
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var _email;
  var _password;
  var _uname;
  final nameCon = new TextEditingController();
  final emailCon = new TextEditingController();
  final passwordCon = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var user = FirebaseAuth.instance.currentUser;
  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.only(top: 70, left: 50, right: 50, bottom: 0),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: nameCon,
          keyboardType: TextInputType.text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Name',
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
          validator: (value) => value.isEmpty ? 'Name can\'t be empty' : null,
          onSaved: (value) {
            _uname['Name'] = value.trim();
          },
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: emailCon,
          keyboardType: TextInputType.text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Email',
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
          onSaved: (value) {
            _email['email'] = value.trim();
          },
        ),
      ),
    );
  }

  Widget _buildpass() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: passwordCon,
          keyboardType: TextInputType.text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
          validator: (value) =>
              value.isEmpty ? 'Password can\'t be empty' : null,
          onSaved: (value) {
            _password['password'] = value.trim();
          },
        ),
      ),
    );
  }

  Widget _buildcpass() {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          controller: passwordCon,
          keyboardType: TextInputType.text,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.lightBlueAccent,
            labelText: 'Confirm Password',
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value != passwordCon.text) {
              return 'invalid password';
            }
            return null;
          },
          onSaved: (value) {},
        ),
      ),
    );
  }

  Widget _buildNewUser() {
    return Padding(
      padding: const EdgeInsets.only(top: 30, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xfff48b90),
            blurRadius: 10.0,
            spreadRadius: 1.0,
            offset: Offset(
              5.0,
              5.0,
            ),
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: FlatButton(
          onPressed: () {
            print('Signed up');
            auth
                .createUserWithEmailAndPassword(
                    email: emailCon.text.trim(),
                    password: passwordCon.text.trim())
                .then((value) => {
                      FirebaseAuth.instance.currentUser.updateProfile(
                        displayName: nameCon.text.trim(),
                      ),
                    });
            print("before it");

            print("after it");

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomeScreen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: TextStyle(
                  color: Color(0xff8a0a3d),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Color(0xff8a0a3d),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserOld() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 88),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Have we met before?',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ),
            InkWell(
                child: Container(
                  child: Text(
                    'Sign in',
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                })
          ],
        ),
      ),
    );
  }

  Widget _buildSignUp() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Sign Up',
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }

  Widget _buildTextNew() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 20.0),
      child: Container(
        //color: Colors.green,
        height: 200,
        width: 200,
        child: Column(
          children: <Widget>[
            Container(
              height: 70,
            ),
            Center(
              child: Text(
                'Watch out your health',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Color(0xfff48b90), Color(0xff8a0a3d)]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _buildSignUp(),
                    _buildTextNew(),
                  ],
                ),
                _buildName(),
                _buildEmail(),
                _buildpass(),
                _buildcpass(),
                _buildNewUser(),
                _buildUserOld(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  createAlertDialog1(BuildContext context) {
    TextEditingController customController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'INVALID LOGIN',
                  style: TextStyle(
                      color: Color.fromRGBO(159, 163, 167, 1),
                      fontFamily: 'Arimo',
                      fontSize: 14.5),
                ),
              ],
            ),
            elevation: 20.0,
          );
        });
  }
}
