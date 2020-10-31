import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Presenter/HomePresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/AddPostPage.dart';
import 'package:volks_demo/Views/HomePage/Tabs/ActivityListTab.dart';
import 'package:volks_demo/Views/HomePage/Tabs/FollowersPostListTab.dart';
import 'package:volks_demo/Views/HomePage/Tabs/PostListTab.dart';
import 'package:volks_demo/Views/ProfilePage.dart';
import 'package:volks_demo/Views/SignInPage.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class HomePage extends StatefulWidget {
  User user;
  final homePresenter = new HomePresenter();

  HomePage(this.user);
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultTabController(
          initialIndex: 0,
          length: 3,
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
                drawer: Drawer(
                    // Add a ListView to the drawer. This ensures the user can scroll
                    // through the options in the drawer if there isn't enough vertical
                    // space to fit everything.
                    child: ListView(
                        // Important: Remove any padding from the ListView.
                        padding: EdgeInsets.zero,
                        children: <Widget>[
                      DrawerHeader(
                        decoration: BoxDecoration(color: MyColors.UpBarHome),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            ListTile(
                              leading: Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipOval(
                                      child: getProfileImage(
                                          widget.user.username))),
                              subtitle: Text(
                                widget.user.username,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
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
                      )
                    ])),
                appBar: AppBar(
                  centerTitle: true,
                  title: Text('Volks App',
                      style: TextStyle(color: MyColors.UpBarHome)),
                  actions: <Widget>[],
                  bottom: TabBar(
                    isScrollable: true,
                    labelColor: MyColors.primaryColor,
                    indicatorColor: MyColors.primaryColor,
                    unselectedLabelColor: MyColors.secondaryColor,
                    labelPadding: EdgeInsets.only(left: 25, right: 25),
                    tabs: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, right: 8.0),
                        child: Text("Post", style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Text("Follower's post",
                            style: TextStyle(fontSize: 18)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0),
                        child: Text("Activity", style: TextStyle(fontSize: 18)),
                      ),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: <Widget>[
                    Container(child: PostListTab(widget.user)),
                    Container(
                      child: FollowerPostListTab(widget.user),
                    ),
                    Container(child: ActivityListTab(user: widget.user)),
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
                        icon:
                            Icon(Icons.message, color: MyColors.secondaryColor),
                        title: Text("Messages",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.secondaryColor)),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.group, color: MyColors.secondaryColor),
                        title: Text("Volks",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.secondaryColor)),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.add, color: MyColors.secondaryColor),
                        title: Text("Add",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.secondaryColor)),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.notifications,
                            color: MyColors.secondaryColor),
                        title: Text("Notifications",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.secondaryColor)),
                      ),
                      BottomNavigationBarItem(
                        icon:
                            Icon(Icons.person, color: MyColors.secondaryColor),
                        title: Text("Profile",
                            style: TextStyle(
                                fontSize: 14, color: MyColors.secondaryColor)),
                      ),
                    ],
                    onTap: (val) {
                      print(val);

                      switch (val) {
                        case 1:
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    VolksPage(this.widget.user),
                              ),
                            );
                            break;
                          }
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
                )),
          )),
    );
  }
}
