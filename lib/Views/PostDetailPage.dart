import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Utils/UserAvatarCircle.dart';
import 'package:volks_demo/Views/HomePage.dart';


class PostDetailPage extends StatefulWidget {

  Post post;
  User user;
  PostDetailPage(this.post,this.user);
  @override
  State<StatefulWidget> createState() => PostDetailPageState();
}


class PostDetailPageState extends State<PostDetailPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: MyColors.bkColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: MyColors.UpBarHome,

          ),
          body: PostSingleView(post: widget.post),

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
                  icon: Icon(
                      Icons.message),
                  title: Text("Messages"),
                ),

                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("Home"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.edit_location),
                  title: Text("Location"),

                ),

              ],
              onTap: (val){
                print(val);

                switch(val)
                {
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
        );
  }
}

class PostSingleView extends StatefulWidget {
  const PostSingleView({
    Key key,
    this.post,
  }) : super(key: key);
  final Post post;

  @override
  PostSingleViewState createState() {
    return new PostSingleViewState();
  }
}

class PostSingleViewState extends State<PostSingleView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Stack(
        children: <Widget>[
          GestureDetector(
            child: PostItemView(item: widget.post),
          ),
          UserAvatar(
            height: 50.0,
            width: 50.0,
            company: widget.post.username,
          ),
        ],
      ),
    );
  }
}

class PostItemView extends StatefulWidget {
   PostItemView({
    Key key,
    this.item,
  }) : super(key: key);

  final Post item;

  GlobalKey cardkey = GlobalKey();
  @override
  PostItemViewState createState() {
    return PostItemViewState();
  }
}

class PostItemViewState extends State<PostItemView>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Card(
        key: widget.cardkey,
        color: MyColors.PostColor,
        elevation: 5.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 30.0, top: 20.0, right: 10.0, bottom: 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.item.username,
                    style: TextStyle(
                        fontSize: 20.0, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[


                    Expanded(
                        flex: 5,
                        child:Container(
                          height: MediaQuery.of(context).size.height *0.6,
                          padding: EdgeInsets.only(top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,//.horizontal
                            child: Text(
                              widget.item.description,
                              maxLines: null,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.white70),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      color: Colors.white70,
                    ),
                    Text(
                      widget.item.posted_in ?? "",
                      style: TextStyle(color: Colors.white),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    /*Text(
                      widget.item.position ?? "",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),*/
                    Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


double calculateHeight(String content)
{

  print(content.length);

  if(content.length>0 && content.length<=100)
    return 50;
  else if(content.length>100 && content.length<200)
    return 160;
  else{
    return 200;
  }

}


