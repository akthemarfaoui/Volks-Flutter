

import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/User.dart';

import 'ProfilePage.dart';


class HomePage extends StatelessWidget {

  User user;


  HomePage(this.user);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {


            }),
        actions: [
          IconButton(
              icon: Icon(Icons.person),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute( builder: (context)=> ProfilePage(user) ));

              })
        ],
      ),
    );
  }
}