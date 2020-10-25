import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_formfield/flutter_datetime_formfield.dart';
import 'package:volks_demo/Model/ViewModel/SignUpViewModel.dart';
import 'package:volks_demo/Presenter/SignUpPresenter.dart';

class ISignUpView {
  void UpdateSignUpPage(SignUpViewModel signUpViewModel) {}
}

class SignUpPage extends StatelessWidget {
  SignUpPage(); // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: new Color(0xff622F74),
      ),
      home: SignUp(),
    );
  }
}

class SignUp extends StatefulWidget {
  final SignUpPresenter signUpPresenter = new SignUpPresenter();

  @override
  State<StatefulWidget> createState() => SignUpState();
}

class SignUpState extends State<SignUp> implements ISignUpView {
  int valueGender;
  DateTime finaldate;

  SignUpViewModel signUpViewModel;
  String ErrorMessage = "";
  String _username = "";
  String _password = "";
  String _confirmPassword = "";
  String _gender = "";
  final _formKey = GlobalKey<FormState>();
  int errorCode = 0;
  DateTime _dateTime;

  final UsernameTextFieldController = TextEditingController();
  final PasswordTextFieldController = TextEditingController();
  final ConfirmPasswordTextFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.signUpPresenter.signUpView = this;
  }

  @override
  void didUpdateWidget(SignUp oldWidget) {
    super.didUpdateWidget(oldWidget);

    this.widget.signUpPresenter.signUpView = this;
  }

  @override
  void UpdateSignUpPage(SignUpViewModel signUpViewModel) {
    setState(() {
      this.ErrorMessage = signUpViewModel.ErrorMessage;
      this.errorCode = signUpViewModel.ErrorCode;
    });

    if (_formKey.currentState.validate()) {
      AlertDialog alert = new AlertDialog(
        title: Text("User adding"),
        content: Text("User added successfully"),
        actions: [
          FlatButton(
              onPressed: () {
                setState(() {
                  UsernameTextFieldController.clear();
                  PasswordTextFieldController.clear();
                  ConfirmPasswordTextFieldController.clear();
                });

                Navigator.of(context, rootNavigator: true)
                    .pop(false); // dismisses only the dialog and returns false
              },
              child: Text("Ok")),
          FlatButton(onPressed: () {}, child: Text("Continue To Profile"))
        ],
      );

      this
          .widget
          .signUpPresenter
          .doSignUp(_gender, _dateTime, _username, _password, _confirmPassword)
          .then((value) => {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    }),
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: UsernameTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Username Field Is Required";
                  } else {
                    if (errorCode == 1) {
                      return this.ErrorMessage;
                    } else {}
                  }
                },
                onSaved: (value) => _username = value,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: PasswordTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password Field Is Required";
                  }
                },
                onSaved: (value) => _password = value,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: TextFormField(
                controller: ConfirmPasswordTextFieldController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Confirm Password Field Is Required";
                  } else {
                    if (value != _password) {
                      return "Confirm Password & Password doesnt match !";
                    }
                  }
                },
                onSaved: (value) => _confirmPassword = value,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropDownFormField(
                    titleText: 'Choose a Gender',
                    hintText: _gender,
                    onSaved: (value) {
                      setState(() {
                        if (value != null) {
                          _gender = value;
                        }
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          _gender = value;
                        }
                      });
                    },
                    dataSource: [
                      {"display": "Female", "value": "Female"},
                      {"display": "Male", "value": "Male"}
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value == null) {
                        return "Gender Field Is Required";
                      }
                    },
                  ),
                  DateTimeFormField(
                    onlyDate: true,
                    initialValue: DateTime(DateTime.now().year - 18),
                    firstDate: DateTime((DateTime.now().year - 100)),
                    lastDate: DateTime(DateTime.now().year - 18),
                    label: "Birth Date",
                    validator: (DateTime dateTime) {
                      if (dateTime == null) {
                        return "Date Time Required";
                      }
                      return null;
                    },
                    onSaved: (DateTime dateTime) => _dateTime = dateTime,
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                child: RaisedButton(
                    onPressed: () {
                      _formKey.currentState.save();
                      _formKey.currentState.validate();
                      this
                          .widget
                          .signUpPresenter
                          .doCheckUsernameExist(_username);
                    },
                    child: Text("Confirm"))),
          ],
        ),
      )),
    );
  }
}
