import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Comment.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/PostDetailPageViewModel.dart';
import 'package:volks_demo/Presenter/PostDetailPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/HomePage/HomePage.dart';

import 'Tabs/CommentPageTab.dart';
import 'Tabs/PostDetailPageTab.dart';


class IPostDetailPage{
  void doUpdatePostDetailPage(PostDetailPageViewModel postDetailPageViewModel) {

  }


}



class PostDetailPage extends StatefulWidget {
  Post post;
  User user;
  final postDetailPresenter = PostDetailPresenter();
  int nbComments=0;
  PostDetailPage(this.post, this.user,this.nbComments);
  @override
  State<StatefulWidget> createState() => PostDetailPageState();
}

class PostDetailPageState extends State<PostDetailPage> implements IPostDetailPage  {

  bool closeModal = false;
  @override
  void doUpdatePostDetailPage(PostDetailPageViewModel postDetailPageViewModel) {

    setState(() {

      if(postDetailPageViewModel.successfullyInserted)
        {
          Navigator.pop(context);
        }
    });


  }




  @override
  void initState() {
    super.initState();
    this.widget.postDetailPresenter.iPostDetailView = this;
  }

  @override
  void didUpdateWidget(PostDetailPage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this.widget.postDetailPresenter.iPostDetailView = this;

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Theme(
          data: ThemeData(
            primaryColor: MyColors.primaryColor,
            appBarTheme: AppBarTheme(
              color: Colors.white,
              textTheme: TextTheme(
                title: TextStyle(
                  color: MyColors.secondaryColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              iconTheme: IconThemeData(color: MyColors.secondaryColor),
              actionsIconTheme: IconThemeData(
                color: MyColors.secondaryColor,
              ),
            ),
          ),
          child: Scaffold(
            backgroundColor: Theme.of(context).buttonColor,
            appBar: AppBar(
              centerTitle: true,
              title: Text('Post'),
              leading: Icon(Icons.textsms),
              actions: <Widget>[],
              bottom: TabBar(
                isScrollable: true,
                labelColor: MyColors.primaryColor,
                indicatorColor: MyColors.primaryColor,
                unselectedLabelColor: MyColors.secondaryColor,
                labelPadding: EdgeInsets.only( left: 50,right: 50),
                tabs: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only( top:8.0,bottom: 8.0,right: 50),
                    child: Text("Post",style: TextStyle(fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( top:8.0,bottom: 8.0,left: 50),
                    child: Text("Comments ("+this.widget.nbComments.toString()+")",style: TextStyle(fontSize: 18)),
                  ),

                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[

                Container(
                  child: PostSingleView(post: widget.post)
                ),
                Container(
                  child: CommentPageTab(widget.post),
                ),

              ],
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                // sets the background color of the `BottomNavigationBar`
                canvasColor: Colors.white,
                // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                primaryColor: Theme.of(context).accentColor,
                textTheme: Theme.of(context).textTheme.copyWith(
                      caption: TextStyle(color: Colors.grey[500]),
                    ),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.message,color: MyColors.secondaryColor),
                    title: Text("Comment"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home,color: MyColors.secondaryColor),
                    title: Text("Home"),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit_location,color: MyColors.secondaryColor),
                    title: Text("Location"),
                  ),
                ],
                onTap: (val) {

                  switch (val) {

                    case 0:
                    {

                      TypeCommentModalBottomSheet(context,closeModal,widget.user,widget.post,TextEditingController(),widget.postDetailPresenter);

                      break;
                    }
                    case 1:
                      {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(widget.user),
                          ),
                        );
                        break;
                      }
                  }
                },
              ),
            ),
          ),
        ));
  }


}


void TypeCommentModalBottomSheet(context,bool close,User user,Post post,TextEditingController commentEditText,PostDetailPresenter commentPresenter) {

  showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child:   Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width *0.9,
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
                    child: TextField(
                      controller: commentEditText,
                      maxLines: 8,
                      //controller: DescriptionTextEditController,
                      decoration: InputDecoration(
                          hintText: ' Type your comment...'),
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 10,
                    child: RaisedButton(
                      child: new Text("Comment"),
                      textColor: MyColors.bkColor,
                      color: MyColors.commentColor,
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      onPressed: () {

                        if(!commentEditText.value.text.isEmpty)
                        {

                          Comment comment = Comment.forAdding(username: user.username,post: post.id,comment: commentEditText.value.text);
                          commentPresenter.doAddComment(comment);

                        }




                      },
                    ),
                  ),

                  Spacer()
                ],
              ),
            ),
          ),
        );
      });
}

double calculateHeight(String content) {

  if (content.length > 0 && content.length <= 100)
    return 50;
  else if (content.length > 100 && content.length < 200)
    return 160;
  else {
    return 200;
  }

}


