import 'package:flutter/material.dart';
import 'package:volks_demo/API/FlutterMap.dart';
import 'package:volks_demo/API/GeoCoding.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Repository/MessageRepositoy.dart';
import 'package:volks_demo/Model/ViewModel/SignInViewModel.dart';
import 'package:volks_demo/Presenter/MessagingPresenter.dart';
import 'package:volks_demo/Presenter/SignInPresenter.dart';
import 'package:volks_demo/Views/HomePage/HomePage.dart';
import 'package:volks_demo/Views/SignUpPage.dart';

class ILoginView {
  void UpdateLoginMessage(SignInViewModel signInViewModel) {}
  void UpdateRemeberedUser(SignInViewModel signInViewModel){}
}

class SignInPage extends StatelessWidget {
  SignInPage(); // This widget is the root of your application.
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

class _LoginState extends State<Login> implements ILoginView {

  SignInViewModel signInViewModel;
  String message = '';
  String _username = '';
  String _password = '';
  int errorCode = 0;
  bool _rememberMe =false;
  User userRembered;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    this.widget.presenter.loginView = this;
    this.widget.presenter.doCheckForRemeberMe();

  }



  @override
  void didUpdateWidget(Login oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    this.widget.presenter.loginView = this;
  }

  @override
  void UpdateRemeberedUser(SignInViewModel signInViewModel) {

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(signInViewModel.UserRemebered)));

  }
  @override
  void UpdateLoginMessage(SignInViewModel signInViewModel) {

    setState(() {
      if (signInViewModel.AccessGranted) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HomePage(signInViewModel.ConnectedUser)));

      }else{

        this.errorCode = signInViewModel.ErrorCode;
        this.message = signInViewModel.Message;

      }
      _formKey.currentState.validate();

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body:  Form(
        key: _formKey,
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
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Username'),
                      validator: (value){

                        print("validator "+errorCode.toString());

                      if(value.isEmpty)
                        {
                          return 'Username Field Is Required';
                        }else{

                        if(errorCode == 1)
                          {
                          return message;
                          }else{
                          return null;
                        }
                      }
                      },
                      onSaved: (value)=>_username = value,

                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 50,
                    margin: EdgeInsets.only(top: 32),
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
                      obscureText: true,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.vpn_key,
                            color: Colors.black,
                          ),
                          hintText: 'password'),

                      validator: (value){
                        print(value);
                        if(value.isEmpty)
                        {

                          return 'Password Field Is Required';

                        }else{

                          if(errorCode == 2)
                          {
                            return message;
                          }else{
                            return null;
                          }
                        }
                      },
                      onSaved: (value)=> _password = value,
                    ),
                  ),
                  Spacer(),

                  Column(

                    children: [
                      Row(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            child: new Text("login"),
                            color: Colors.pinkAccent,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {

                              _formKey.currentState.save();
                              _formKey.currentState.validate();

                              this.widget.presenter.doTrySignIn(
                                  _rememberMe,
                                  _username,
                                  _password);

                            },
                          ),
                          RaisedButton(
                            child: new Text("Sign Up"),
                            color: Colors.pinkAccent,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignUp()));
                            },
                          ),
                          Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Remember Me"),
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value){

                                  setState(() {

                                    _rememberMe=value;

                                  });

                                } ,

                              ),

                            ],
                          ),
                        ],
                      ),
                    ],
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
