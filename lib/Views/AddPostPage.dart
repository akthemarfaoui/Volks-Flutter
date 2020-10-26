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
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.account_circle, size: 50),
                        title: Text(widget.user.username),
                        subtitle: Text('profile'),
                      ),
                      TextFormField(
                        controller: DescriptionTextEditController,
                        decoration: InputDecoration(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ),
                            hintText: 'Write your post here'),
                        minLines: 3,
                        maxLines: 5,
                      ),
                      Row(children: [
                        ButtonBar(
                          children: <Widget>[
                            FlatButton(
                              child: const Text('Add Post',
                                  style: TextStyle(color: Colors.pink)),
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
                            /* FlatButton(
                              child: const Text('Show Profile',
                                  style: TextStyle(color: Colors.pink)),
                              onPressed: () {},
                            ), */
                          ],
                        ),
                      ]),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
