import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Comment.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/ViewModel/PostDetailPageViewModel.dart';
import 'package:volks_demo/Presenter/PostDetailPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Utils/UserAvatarCircle.dart';


class ICommentPageTab
{
  void doUpdateCommentPageTab(PostDetailPageViewModel postDetailPageViewModel)
  {

  }

}

class CommentPageTab extends StatefulWidget {

  final postDetailPresenter = PostDetailPresenter();
  Post post;

  CommentPageTab(this.post){

  }

  @override
  State<StatefulWidget> createState() => CommentPageState();
}

class CommentPageState extends State<CommentPageTab> implements ICommentPageTab {

  List<Comment> commentList = [];
  Future<List<Comment>> fcommentsList;
  bool loading = true ;

  Future<List<Comment>> getData() async {
    this.widget.postDetailPresenter.doGetComments(widget.post.id);
    return this.fcommentsList;
  }

  @override
  void doUpdateCommentPageTab(PostDetailPageViewModel postDetailPageViewModel) {

    setState(() {

      this.commentList = postDetailPageViewModel.listComment;
      this.fcommentsList = postDetailPageViewModel.FuturelistComment;

    });


  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.widget.postDetailPresenter.iCommentPageTab = this;
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }
 @override
  void didUpdateWidget(CommentPageTab oldWidget) {

    super.didUpdateWidget(oldWidget);
    this.widget.postDetailPresenter.iCommentPageTab = this;

 }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: MyColors.bgColor,
      body: !loading
          ? RefreshIndicator(
        onRefresh: () async {
          commentList.clear();
          await getData();
        },
        child: CommentListView(list: commentList),
      ) : Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(MyColors.commentColor)),
      ),

    );

  }

}

class CommentListView extends StatefulWidget {


  const CommentListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Comment> list;

  @override
  State<StatefulWidget> createState() {
    return new CommentListViewState();
  }
}

class CommentListViewState extends State<CommentListView> {


    @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.isNotEmpty
            ? widget.list.map((item) {
          return Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Stack(
              children: <Widget>[
                GestureDetector(
                  key: Key(item.username),

                  child: PostItemView(item: item),
                ),
                UserAvatar(
                  height: 50.0,
                  width: 50.0,
                  username: item.username,
                ),
              ],
            ),
          );
        }).toList()
            : []);
  }
}

class PostItemView extends StatefulWidget {


  const PostItemView({
    Key key,
    this.item,
  }) : super(key: key);

  final Comment item;

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
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
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
    return SlideTransition(
      position: animation,
      child: Card(
        color: MyColors.commentColor,
        elevation: 5.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: InkWell(
          onTap: () {
            //print(widget.item.company.trim());
            /*Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailPage(widget.item,USER),
              ),
            );*/
          },
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
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 15,top: 10),
                        height: calculateHeight(widget.item.comment) ,
                        child:Text(
                          widget.item.comment,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.white70),
                        ),
                      ),
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
                      "Nmlt Date Houni",
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

double calculateHeight(String content) {
  print(content.length);

  if (content.length > 0 && content.length <= 100)
    return 50;
  else if (content.length > 100 && content.length < 200)
    return 160;
  else {
    return 200;
  }
}

