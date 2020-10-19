import 'package:flutter/material.dart';

class UserCustomWidget extends StatelessWidget {
  String srcImage, Username;

  UserCustomWidget(this.srcImage, this.Username);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Username),
              ],
            ),
          )
        ],
      ),
    );
  }
}
