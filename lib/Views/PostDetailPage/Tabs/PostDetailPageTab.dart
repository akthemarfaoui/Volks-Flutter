import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Utils/UserAvatarCircle.dart';

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
        child: Container(
          child: Stack(

            children: <Widget>[
              GestureDetector(
                child: PostItemView(item: widget.post),
              ),
              UserAvatar(
                height: 50.0,
                width: 50.0,
                username: widget.post.username,
              ),
            ],
          ),
        )
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
  TextEditingController commentEditText = TextEditingController();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);

    animation = Tween<Offset>(begin: Offset(200.0, 0.0), end: Offset(0.0, 0.0))
        .animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: SlideTransition(
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
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Text(
                                widget.item.username,
                                style: TextStyle(
                                    fontSize: 22.0, color: Colors.black87, fontWeight: FontWeight.bold),
                              ),

                              SizedBox(
                                height: 10,

                              ),

                              Row(

                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,

                                  ),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Container(
                                      child:Text(
                                        getFormatedDateFromSQl(widget.item.posted_in),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(

                                            fontSize: 18.0, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),


                              SizedBox(
                                height: 5,
                              ),

                              widget.item.position != null && widget.item.position!="" ?  Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  SizedBox(
                                    width: 5,

                                  ),
                                  Icon(Icons.location_on,size: 14,color: Colors.white70,),
                                  SizedBox(width: 5,),
                                  Flexible(
                                    child: Container(
                                      child:Text(
                                        widget.item.position ,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(

                                            fontSize: 14.0, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ):SizedBox(

                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.5,
                            padding: EdgeInsets.only(top: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical, //.horizontal
                              child: Text(
                                widget.item.description,
                                maxLines: null,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Barlow",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18.0,

                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 10.0),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

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
