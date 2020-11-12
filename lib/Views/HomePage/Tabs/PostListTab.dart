import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/HomeViewModel.dart';
import 'package:volks_demo/Presenter/HomePresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Utils/UserAvatarCircle.dart';
import 'package:volks_demo/Views/PostDetailPage/PostDetailPage.dart';


class IHomeView
{

 void UpdateHomePage(HomeViewModel homeViewModel)
 {

 }


}

class IPostItemView
{
  void UpdatePostItemView(HomeViewModel homeViewModel)
  {

  }
}



User USER;
class PostListTab extends StatefulWidget {

  User user;

  final homePresenter= new HomePresenter();

  PostListTab(this.user){
    USER = user;
  }
  @override
  State<StatefulWidget> createState() => HomePageState();
}


class HomePageState extends State<PostListTab> implements IHomeView {
  List<Post> postsList = [];
  Future<List<Post>> fpostsList;

  @override
  void UpdateHomePage(HomeViewModel homeViewModel) {

    setState(() {

      this.postsList = homeViewModel.listPost;
      this.fpostsList = homeViewModel.FuturelistPost;

    });

  }

Future<List<Post>> getData() async {
    this.widget.homePresenter.doGetPosts();
    return this.fpostsList;
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();

    this.widget.homePresenter.iHomeView = this;

   // this.widget.homePresenter.doGetPosts();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void didUpdateWidget(PostListTab oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this.widget.homePresenter.iHomeView = this;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child:Scaffold(
backgroundColor: Theme.of(context).buttonColor,
      body: !loading
          ? RefreshIndicator(
        onRefresh: () async {
          postsList.clear();
          await getData();
        },
        child: PostListView(list: postsList),
      )
          : Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(MyColors.PostColor)),
      ),

    ) ,onWillPop:() async => false);


  }


}

class PostListView extends StatefulWidget {
  const PostListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Post> list;

  @override
  PostListViewState createState() {
    return new PostListViewState();
  }
}

class PostListViewState extends State<PostListView> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
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

  final homePresenter = new  HomePresenter();

   PostItemView({

    Key key,
    this.item,
  }) : super(key: key);

  final Post item;
  int nbComments = 0;
  @override
  PostItemViewState createState() {
    return PostItemViewState();
  }
}

class PostItemViewState extends State<PostItemView>
    with SingleTickerProviderStateMixin implements IPostItemView {
  Animation animation;
  AnimationController animationController;


  @override
  void UpdatePostItemView(HomeViewModel homeViewModel) {
    setState(() {
      this.widget.nbComments = homeViewModel.nbComments;
    });

  }


@override
  void didUpdateWidget(PostItemView oldWidget) {

    super.didUpdateWidget(oldWidget);
    widget.homePresenter.iPostItemView = this;

}

  @override
  void initState() {
    super.initState();
    widget.homePresenter.iPostItemView = this;

    widget.homePresenter.doGetNbComment(widget.item.id);
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
        color: MyColors.PostColor,
        elevation: 5.0,
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: InkWell(
          onTap: () {
            //print(widget.item.company.trim());
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PostDetailPage(widget.item,USER,widget.nbComments),
              ),
            );
          },
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
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 15,top: 10),
                        height: calculateHeight(widget.item.description) ,
                        child:Text(
                          widget.item.description,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.white,fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),


                SizedBox(
                  height: 10.0,
                ),

                Divider(
                  thickness: 0.7,
                  color: Colors.black.withOpacity(1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.nbComments.toString(),style: TextStyle(fontSize: 18)),
                        SizedBox(
                          width: 3.0,
                        ),
                        Icon(Icons.comment),
                        SizedBox(
                          width: 10.0,
                        ),
                        //Text('4k'),
                        /*SizedBox(
                          width: 3.0,
                        ),
                        Icon(Icons.favorite),*/
                      ],
                    ),
                  ],
                )

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

  //print(content.length);

    if(content.length>0 && content.length<=100)
      return 50;
    else if(content.length>100 && content.length<200)
      return 160;
    else{
      return 200;
    }
  


}


