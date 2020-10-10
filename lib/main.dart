import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volks_demo/Views/homepage.dart';
import 'Views/loginpage.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

String username;

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cars Agency",
      theme: ThemeData(
        primaryColor: new Color(0xff622F74),
      ),
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/homepage': (BuildContext context) => new Homepage(),
        '/loginpage': (BuildContext context) => new Loginpage(),

        //
      },
    );
  }
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController controlleurUsername = new TextEditingController();
  TextEditingController controlleurPassword = new TextEditingController();

  String message = '';
  Future<List> Login() async {
    final response =
        await http.post("http://10.0.2.2/project_db/login.php", body: {
      "username": controlleurUsername.text,
      "password": controlleurPassword.text,
    });

    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        message = "user not found";
      });
    } else {
      Navigator.pushReplacementNamed(context, '/loginpage');
    }
    setState(() {
      username = datauser[0]['username'];
    });
    return datauser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Form(
          child: Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage("assets/images/p.jpg"),
                fit: BoxFit.cover)),
        child: Column(
          children: [
            new Container(
              padding: EdgeInsets.only(top: 77.0),
              child: new CircleAvatar(
                backgroundColor: Color(0xF81F7F3),
                child: new Image(
                    height: 135,
                    width: 135,
                    image: new AssetImage("assets/images/logoVolks.png")),
              ),
              width: 170.0,
              height: 170.0,
              decoration: BoxDecoration(shape: BoxShape.circle),
            ),
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 93),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: controlleurUsername,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'username'),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
                    padding:
                        EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: TextFormField(
                      controller: controlleurPassword,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'password'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 6,
                        right: 32,
                      ),
                      child: Text(
                        'Save Password',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                  new RaisedButton(
                    child: new Text("login"),
                    color: Colors.pinkAccent,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0),
                    ),
                    onPressed: () {
                      Login();
                      //Navigator.pop(context);
                      //
                    },
                  ),
                  Text(
                    message,
                    style: TextStyle(fontSize: 25.0, color: Colors.red),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
