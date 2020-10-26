import 'package:flutter/material.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';

class UserCustomWidget extends StatelessWidget {
  String srcImage, Username;

  UserCustomWidget(this.srcImage, this.Username);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Container(width:50 ,height:50 ,  child: ClipOval(child: getProfileImage(Username))),
            title: Text(Username),
            subtitle: Text('profile'),
          ),
          Row(children: [
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child:
                      const Text('Add', style: TextStyle(color: Colors.pink)),
                  onPressed: () {},
                ),
                FlatButton(
                  child: const Text('Show Profile',
                      style: TextStyle(color: Colors.pink)),
                  onPressed: () {},
                ),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
