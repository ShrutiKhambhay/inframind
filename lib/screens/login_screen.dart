import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackhealth/pages/userauth.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ignore: unused_field
  final _formKey = GlobalKey<FormState>();
  FirebaseAuth auth = FirebaseAuth.instance;
  var _email;
  var _password;

  final emailCon = new TextEditingController();
  final passwordCon = new TextEditingController();
  Widget _buildEmailTF() {
    return Padding(
      padding: const EdgeInsets.only(top: 130, left: 50, right: 50),
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
          validator: (value) {
            if (value.isEmpty || !value.contains('@')) {
              return 'invalid email';
            }
            return null;
          },
          onSaved: (value) => _email['email'] = value.trim(),
        ),
      ),
    );
  }

  Widget _buildTextLogin() {
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
                'Keep Track of your Health',
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

  Widget _buildVerticalText() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 20),
      child: RotatedBox(
          quarterTurns: -1,
          child: Text(
            'Sign in',
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

  Widget _buildPasswordTF() {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          cursorColor: Colors.white,
          controller: passwordCon,
          keyboardType: TextInputType.text,
          obscureText: true,
          style: GoogleFonts.raleway(
            textStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: 'Password',
            labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
          validator: (value) {
            if (value.isEmpty || value.length <= 5) {
              return 'invalid password';
            }
            return null;
          },
          onSaved: (value) => _password['password'] = value.trim(),
        ),
      ),
      //],
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 60, right: 50, left: 200),
      child: Container(
        alignment: Alignment.bottomRight,
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff08aaa0),
              blurRadius: 10.0, // has the effect of softening the shadow
              spreadRadius: 1.0, // has the effect of extending the shadow
              offset: Offset(
                5.0, // horizontal, move right 10
                5.0, // vertical, move down 10
              ),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        child: FlatButton(
          onPressed: () async {
            try {
              final user = await Authenticate.signInWithEmail(
                  email: emailCon.text.trim(),
                  password: passwordCon.text.trim());
              if (user != null) {
                print("login successfull");
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }
            } catch (e) {
              print(e);
            }
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'OK',
                style: GoogleFonts.raleway(
                  textStyle: TextStyle(
                    color: Color(0xFF08aaa0),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward,
                color: Color(0xff08aaa0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignupBtn() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 50,
        left: 110,
        right: 0,
      ),
      child: Container(
        alignment: Alignment.topRight,
        //color: Colors.red,
        height: 20,
        child: Row(
          children: <Widget>[
            Text(
              'Your first time?',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ),
            InkWell(
                child: Container(
                  child: Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignupScreen.routeName);
                })
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
              colors: [Color(0xFF08aaa0), Color(0xFF083663)]),
        ),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Row(children: <Widget>[
                  _buildVerticalText(),
                  _buildTextLogin(),
                ]),
                _buildEmailTF(),
                _buildPasswordTF(),
                _buildLoginBtn(),
                _buildSignupBtn(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

createAlertDialog1(BuildContext context) {
  // ignore: unused_local_variable
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
          //backgroundColor: Color.fromRGBO(34, 45, 54, 1),
        );
      });
}
