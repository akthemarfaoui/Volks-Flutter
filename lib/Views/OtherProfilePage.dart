import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/HomePage.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class OtherProfilePage extends StatefulWidget {
  User user;
  bool didUpdated = false;
  OtherProfilePage(this.user);
  @override
  OtherProfilePageState createState() => OtherProfilePageState();
}

class OtherProfilePageState extends State<OtherProfilePage> {
  GlobalKey keyForm = new GlobalKey();
  bool hide = false;
  bool hide2 = true;
  var FirstNameController = TextEditingController();
  var LastNameController = TextEditingController();
  var PhoneNumberController = TextEditingController();
  var AddressController = TextEditingController();
  var ChildNumberController = TextEditingController();
  var DChildNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirstNameController.text = widget.user.first_name ?? "";
    LastNameController.text = widget.user.last_name ?? "";
    PhoneNumberController.text = widget.user.phone_number.toString() ?? "";
    AddressController.text = widget.user.address ?? "";
    ChildNumberController.text = widget.user.number_children.toString() ?? 0;
    DChildNumberController.text =
        widget.user.number_children_disabilities.toString() ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Form(
          key: keyForm,
          child: new Container(
            color: MyColors.bkColor,
            child: new ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    new Container(
                      height: 250.0,
                      color: MyColors.UpBarHome,
                      child: new Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20.0),
                            child: new Stack(
                                fit: StackFit.loose,
                                children: <Widget>[
                                  new Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          new Container(
                                              width: 140.0,
                                              height: 140.0,
                                              decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                  image: new ExactAssetImage(
                                                      'assets/images/avatar_profile.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              )),
                                          Container(
                                            margin: EdgeInsets.only(top: 30),
                                            child: Text(widget.user.username,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30.0,
                                                    fontFamily:
                                                        'sans-serif-light',
                                                    color: Colors.white)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    new Container(
                      color: MyColors.bkColor,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 25.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Personal Information',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    new Column(
                                      children: [
                                        AnimatedOpacity(
                                            opacity: hide ? 0 : 1,
                                            duration: Duration(seconds: 2),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  hide2 = !hide2;
                                                  hide = !hide;
                                                });
                                              },
                                              child: Text("S'abonner"),
                                              color: Colors.pink,
                                            )),
                                        AnimatedOpacity(
                                            opacity: hide2 ? 0 : 1,
                                            duration: Duration(seconds: 2),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  hide = !hide;
                                                  hide2 = !hide2;
                                                });
                                              },
                                              child: Text(
                                                "Se désabonner",
                                                style: TextStyle(
                                                    color: Colors.pink),
                                              ),
                                              color: Colors.white,
                                            )),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'First Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                          hintText: " First Name",
                                        ),
                                        controller: FirstNameController,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Last Name',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: " Last Name"),
                                        controller: LastNameController,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Phone Number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "Phone Number"),
                                        controller: PhoneNumberController,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        new Text(
                                          'Address',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: " Address"),
                                        controller: AddressController,
                                      ),
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 25.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Children Number',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Expanded(
                                      child: Container(
                                        child: new Text(
                                          'Disabled Children num.',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                            Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 10.0),
                                        child: new TextField(
                                          decoration: const InputDecoration(
                                              hintText: " Children num"),
                                          controller: ChildNumberController,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextField(
                                        decoration: const InputDecoration(
                                            hintText: "D.Children num"),
                                        controller: DChildNumberController,
                                      ),
                                      flex: 2,
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
