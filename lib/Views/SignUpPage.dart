
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/ViewModel/SignUpViewModel.dart';
import 'package:volks_demo/Presenter/SignUpPresenter.dart';


class ISignUpView {

  void UpdateSignUpPage(SignUpViewModel signUpViewModel){}

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

  final SignUpPresenter signUpPresenter=new SignUpPresenter();

  @override
  State<StatefulWidget> createState() => SignUpState();

}


class SignUpState extends State<SignUp> implements ISignUpView
{

  TextEditingController UsernameTextEditController = TextEditingController();
  TextEditingController PasswordTextEditController =TextEditingController();
  TextEditingController ConfirmPasswordTextEditController =TextEditingController();

int valueGender;
DateTime finaldate;

SignUpViewModel signUpViewModel;
String ErrorMessage = "";


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

  });

}


  void callDatePicker() async {
    var order = await getDate();
    setState(() {

      finaldate = order;

    });
  }

  Future<DateTime> getDate() {

    return showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year -18),
      firstDate: DateTime( (DateTime.now().year -100)),
      lastDate: DateTime(DateTime.now().year -18),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: SingleChildScrollView(

        child: Column(

          children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
              controller: UsernameTextEditController,
            ) ,
          ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                controller: PasswordTextEditController,
              ) ,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                ),
                controller: ConfirmPasswordTextEditController,
              ) ,
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child:
              Row(

                mainAxisAlignment: MainAxisAlignment.center ,

                children: [DropdownButton(
                  hint: Text("Gender"),
                  value: valueGender,
                  items: [
                    DropdownMenuItem(
                      child: Text("Female"),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Male"),
                      value: 2,
                    )
                  ],
                  onChanged: (value)  {
                    setState(() {
                      valueGender = value;
                    });

                  },
                ),
                  RaisedButton.icon(

                    icon: Icon(Icons.date_range),
                    label: Text("Birth date"),
                    onPressed:callDatePicker,

                  )

                ],

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
              child: RaisedButton(onPressed: (){

                this.widget.signUpPresenter.doSignUp(valueGender,finaldate,UsernameTextEditController.text,PasswordTextEditController.text,ConfirmPasswordTextEditController.text);

              }, child: Text("Confirm"))
            ),

            Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
                child:

                Text(ErrorMessage,
                  style: TextStyle(fontSize: 25.0, color: Colors.red),

                )

            ),

          ],


        ),

      ),

    );
  }






}