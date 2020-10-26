import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Followers.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/OtherProfileViewModel.dart';
import 'package:volks_demo/Presenter/OtherProfilePresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';

class IOtherProfileView {
  void updateOtherProfilePage(OtherProfileViewModel otherProfileViewModel) {}
}

class OtherProfilePage extends StatefulWidget {
  User connectedUser;
  User user;
  bool didUpdated = false;
  final otherProfilePresenter = OtherProfilePresenter();
  OtherProfilePage({this.user, this.connectedUser});
  @override
  OtherProfilePageState createState() => OtherProfilePageState();
}

class OtherProfilePageState extends State<OtherProfilePage>
    implements IOtherProfileView {
  GlobalKey keyForm = new GlobalKey();
  bool hide = false;
  bool hide2 = false;
  var FirstNameController = TextEditingController();
  var LastNameController = TextEditingController();
  var PhoneNumberController = TextEditingController();
  var AddressController = TextEditingController();
  var ChildNumberController = TextEditingController();
  var DChildNumberController = TextEditingController();

  bool didSuccessffullyAdded = false;
  bool didSuccessffullyDeleted = false;
  bool isFollowing;
  bool statusChange = false;

  @override
  void updateOtherProfilePage(OtherProfileViewModel otherProfileViewModel) {
    setState(() {
      this.isFollowing = otherProfileViewModel.isFollowing;
      this.statusChange = otherProfileViewModel.statusChanged;
      this.didSuccessffullyAdded = otherProfileViewModel.didSuccessfullyAdded;
      this.didSuccessffullyDeleted = otherProfileViewModel.didSuccessffullyDeleted;
    });

    if (!this.statusChange) {
      if (this.isFollowing) {
        setState(() {
          // show se desabonner
          hide = true;
          hide2 = false;
        });
      } else {
        setState(() {
          // show s'abonner
          hide = false;
          hide2 = true;
        });
      }
    } else {
      if (this.didSuccessffullyAdded) {
        hide = true;
        hide2 = false;
      }

      if (this.didSuccessffullyDeleted) {
        hide = false;
        hide2 = true;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    widget.otherProfilePresenter.iOtherProfileView = this;

    widget.otherProfilePresenter
        .doGetOneFollowers(widget.connectedUser.username, widget.user.username);

    FirstNameController.text = widget.user.first_name ?? "";
    LastNameController.text = widget.user.last_name ?? "";
    PhoneNumberController.text = widget.user.phone_number.toString() ?? "";
    AddressController.text = widget.user.address ?? "";
    ChildNumberController.text = widget.user.number_children.toString() ?? 0;
    DChildNumberController.text =
        widget.user.number_children_disabilities.toString() ?? 0;
  }

  @override
  void didUpdateWidget(OtherProfilePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    widget.otherProfilePresenter.iOtherProfileView = this;
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
                            child: new Stack(fit: StackFit.loose, children: <
                                Widget>[
                              new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Card(
                                        child: new Container(
                                          width: 140.0,
                                          height: 140.0,
                                          child: ClipOval(
                                              child: getProfileImage(
                                                  widget.user.username)),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.transparent,
                                              border: Border.all(
                                                  width: 1.0,
                                                  color: Colors.transparent)),
                                        ),
                                        color: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.white70, width: 3),
                                          borderRadius:
                                              BorderRadius.circular(70),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 30),
                                        child: Text(widget.user.username,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30.0,
                                                fontFamily: 'sans-serif-light',
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
                                            duration: Duration(seconds: 0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                Followers follow =
                                                    Followers.forAdding(
                                                        username: this
                                                            .widget
                                                            .connectedUser
                                                            .username,
                                                        following: this
                                                            .widget
                                                            .user
                                                            .username);

                                                this
                                                    .widget
                                                    .otherProfilePresenter
                                                    .doAddFollowers(follow);
                                              },
                                              child: Text("S'abonner"),
                                              color: Colors.pink,
                                            )),
                                        AnimatedOpacity(
                                            opacity: hide2 ? 0 : 1,
                                            duration: Duration(seconds: 0),
                                            child: MaterialButton(
                                              onPressed: () {
                                                setState(() {
                                                  this.widget.otherProfilePresenter.doDeleteFollowers(this.widget.connectedUser.username, this.widget.user.username);
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
                                        readOnly: true,
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
                                        readOnly: true,
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
                                        readOnly: true,
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
                                        readOnly: true,
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
                                          readOnly: true,
                                          decoration: const InputDecoration(
                                              hintText: " Children num"),
                                          controller: ChildNumberController,
                                        ),
                                      ),
                                      flex: 2,
                                    ),
                                    Flexible(
                                      child: new TextField(
                                        readOnly: true,
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
