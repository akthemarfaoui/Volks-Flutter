import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/AddPostViewModel.dart';
import 'package:volks_demo/Presenter/AddPostPresenter.dart';

import 'ProfilePage.dart';




class IAddPostView
{

  void UpdatePostPage(AddPostViewModel addPostViewModel){

  }

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
          title: Text("Posts"),
          leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
          actions: [
            IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfilePage(this.widget.user)));
                })
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
                  width: MediaQuery.of(context).size.width / 1.2,
                  padding:
                  EdgeInsets.only(top: 1, left: 2, right: 16, bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
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
                          Icons.textsms,
                          color: Colors.grey,
                        ),
                        hintText: 'Add Post'),
                  ),
                ),
                //Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                      child: new Text("Add"),
                      color: Colors.purpleAccent,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {

                        this.widget.postPresenter.doAddPost(
                          this.widget.user.username,
                          DescriptionTextEditController.text,
                        );

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

}
