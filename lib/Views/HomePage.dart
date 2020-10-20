import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/HomeViewModel.dart';
import 'package:volks_demo/Presenter/HomePresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Utils/UserAvatarCircle.dart';
import 'package:volks_demo/Views/AddPostPage.dart';
import 'package:volks_demo/Views/PostDetailPage.dart';
import 'package:volks_demo/Views/ProfilePage.dart';
import 'package:volks_demo/Views/SignInPage.dart';



class IHomeView
{

 void UpdateSignUpPage(HomeViewModel homeViewModel)
 {

 }


}
User USER;
class HomePage extends StatefulWidget {

  User user;

  final homePresenter= new HomePresenter();

  HomePage(this.user){
    USER = user;
  }
  @override
  State<StatefulWidget> createState() => HomePageState();
}


class HomePageState extends State<HomePage> implements IHomeView {
  List<Post> postsList = [];
  Future<List<Post>> fpostsList;

  @override
  void UpdateSignUpPage(HomeViewModel homeViewModel) {

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

    this.widget.homePresenter.doGetPosts();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this.widget.homePresenter.iHomeView = this;
    //this.widget.homePresenter.doGetPosts();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope( child:Scaffold(
      backgroundColor: MyColors.bkColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: MyColors.UpBarHome,

      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Username:   => ' + widget.user.username),
              decoration: BoxDecoration(
                color: MyColors.UpBarHome,
              ),
            ),

            ListTile(
              title: Text('Disconnect'),
              onTap: () {

                widget.homePresenter.doLogout();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
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
              icon: Icon(Icons.group),
              title: Text("Volks"),

            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              title: Text("Add"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              title: Text("Notifications"),

            ),
            BottomNavigationBarItem(

              icon: Icon(Icons.person),
              title: Text("Profile"),

            ),
          ],
          onTap: (val){

            print(val);

            switch(val)
            {
              case 2:
               {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => AddPostPage(widget.user),
                   ),
                 );
                 break;
               }
              case 4:
                {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(widget.user),
                    ),
                  );
                  break;
                }

            }


          },
        ),
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
                  company: item.username,
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

  final Post item;

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
                builder: (context) => PostDetailPage(widget.item,USER),
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
                        height: calculateHeight(widget.item.description) ,
                        child:Text(
                          widget.item.description,
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

  //print(content.length);

    if(content.length>0 && content.length<=100)
      return 50;
    else if(content.length>100 && content.length<200)
      return 160;
    else{
      return 200;
    }
  


}


