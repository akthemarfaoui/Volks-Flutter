import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/User.dart';

class ProfilePage extends StatelessWidget {

  User user;

  ProfilePage(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
            icon: Icon(Icons.home),
            onPressed: () {

              print(user.username);

            }),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {


              })
        ],
      ),
    );
  }
}