import 'package:flutter/material.dart';
import 'homepage.dart';

class Loginpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Volks"),
        leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //
            }),
        actions: [
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                //
              })
        ],
      ),
    );
  }
}
