import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/AddPostViewModel.dart';
import 'package:volks_demo/Presenter/AddPostPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';

import 'ProfilePage.dart';

class IAddPostView {
  void UpdatePostPage(AddPostViewModel addPostViewModel) {}
}

class AddPostPage extends StatefulWidget {
  User user;

  AddPostPage(this.user);
  final AddPostPresenter postPresenter = new AddPostPresenter();
  @override
  State<StatefulWidget> createState() => AddPostPageSatate();
}

class AddPostPageSatate extends State<AddPostPage> implements IAddPostView {
  TextEditingController DescriptionTextEditController = TextEditingController();

  @override
  void UpdatePostPage(AddPostViewModel addPostViewModel) {
    setState(() {
      this.ErrorMessage = addPostViewModel.ErrorMessage;
    });
  }

  Post post;

  AddPostViewModel postViewModel;
  String ErrorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Posts'),
          leading: Icon(Icons.edit),
          actions: <Widget>[

          ],
        ),
        body: Form(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: MediaQuery.of(context).size.width / 2,
                  padding:
                      EdgeInsets.only(top: 1, left: 2, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                      )
                    ],
                  ),
                  child: TextFormField(
                    controller: DescriptionTextEditController,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        ),
                        hintText: 'Write your post here'),
                  ),
                ),
                Spacer(),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.width / 10,
                  child: RaisedButton(
                    child: new Text("Add Post"),
                    textColor: MyColors.bkColor,
                    color: MyColors.PostColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      this.widget.postPresenter.doAddPost(
                            this.widget.user.username,
                            DescriptionTextEditController.text,
                          );
                      DescriptionTextEditController.text = "";

                      // set up the button
                      Widget okButton = FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                      // set up the AlertDialog
                      AlertDialog alert = AlertDialog(
                        title: Text("Done"),
                        content: Text("Post Added Successfully"),
                        actions: [
                          okButton,
                        ],
                      );
                      // show the dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
