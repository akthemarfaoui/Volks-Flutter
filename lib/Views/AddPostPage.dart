import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/AddPostViewModel.dart';
import 'package:volks_demo/Presenter/AddPostPresenter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  Post post;
  AddPostViewModel postViewModel;
  bool didAddedSucceffully = false;
  bool withPosition =false;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void UpdatePostPage(AddPostViewModel addPostViewModel) {
    setState(() {
      this.didAddedSucceffully = addPostViewModel.didAddedSuccessfully;
      this.loading = addPostViewModel.loading;
      if(this.didAddedSucceffully)
        {
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
        }
    });
  }
  @override
  void initState() {
    super.initState();
    this.widget.postPresenter.iAddPostView = this;
  }

  @override
  void didUpdateWidget(AddPostPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.postPresenter.iAddPostView = this;
  }




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
          key: _formKey,
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
                        validator: (value){
                          if(value.isEmpty)
                            {
                              return "Description field is required";
                            }
                        },

                      ),
                      Row(
                        mainAxisAlignment:  MainAxisAlignment.spaceAround,
                          children: [

                            Container(

                              child:loading ? Center(
                                child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(MyColors.PostColor)),
                              ): FlatButton(
                                child: const Text('Add Post',
                                    style: TextStyle(color: Colors.pink)),
                                onPressed: () {


                                  this.widget.postPresenter.doAddPost(
                                      this.widget.user.username,
                                      DescriptionTextEditController.text,
                                      withPosition);
                                  DescriptionTextEditController.text = "";


                                },
                              ),
                            ),
                        Row(

                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("With Location",style: TextStyle(color: Colors.pink)),
                            Checkbox(
                              value: withPosition,
                              onChanged: (value){

                                setState(() {

                                  withPosition=value;

                                });

                              } ,

                            ),

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
