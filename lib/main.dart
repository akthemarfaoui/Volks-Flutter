import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volks_demo/Model/ViewModel/SignInViewModel.dart';
import 'package:volks_demo/Presenter/SignInPresenter.dart';
import 'package:volks_demo/Views/SignUpPage.dart';
import 'package:volks_demo/Views/homepage.dart';
import 'Views/loginpage.dart';

void main() {
  runApp(MyApp());
}

String username;


class ILoginView{

  void UpdateLoginMessage(SignInViewModel MessageViewModel){}

}

class MyApp extends StatelessWidget {

  MyApp(); // This widget is the root of your application.
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
  final SignInPresenter presenter = new SignInPresenter();

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> implements ILoginView  {

  TextEditingController controlleurUsername = new TextEditingController();
  TextEditingController controlleurPassword = new TextEditingController();
  SignInViewModel signInViewModel;
  String message = '';

  @override
  void didUpdateWidget(Login oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    this.widget.presenter.loginView = this;

  }

  @override
  void UpdateLoginMessage(SignInViewModel MessageViewModel) {

    setState(() {
      this.message = MessageViewModel.Message;
    });

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
                          hintText: 'Username'),
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
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'password'),
                    ),
                  ),

                  Spacer(),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [RaisedButton(
                       child: new Text("login"),
                       color: Colors.pinkAccent,
                       shape: new RoundedRectangleBorder(
                         borderRadius: new BorderRadius.circular(30.0),
                       ),
                       onPressed: ()  {

                         this.widget.presenter.doSignIn(controlleurUsername.text, controlleurPassword.text);

                         },
                     ),RaisedButton(
                       child: new Text("Sign Up"),
                       color: Colors.pinkAccent,
                       shape: new RoundedRectangleBorder(
                         borderRadius: new BorderRadius.circular(30.0),
                       ),
                       onPressed: ()  {


                         Navigator.push(context, MaterialPageRoute( builder: (context)=> SignUpPage()));


                       },
                     )],
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
