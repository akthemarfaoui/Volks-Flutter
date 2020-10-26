import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Entity/followers.dart';
import 'package:volks_demo/Model/ViewModel/VolksViewModel.dart';
import 'package:volks_demo/Presenter/VolksPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/CustomWidget/UserCustomWidget.dart';
import 'package:volks_demo/Views/HomePage/HomePage.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';
import 'package:volks_demo/Views/ProfilePage.dart';

class IVolksView {
  void UpdateVolksPage(VolksViewModel volksViewModel) {}
}

class VolksPage extends StatefulWidget {
  User user;
  final volksPresenter = new VolksPresenter();
  List<String> names = [];
  List<String> followersnames = [];
  VolksPage(this.user);

  @override
  _VolksPageHomeState createState() => new _VolksPageHomeState();
}

class _VolksPageHomeState extends State<VolksPage> implements IVolksView {
  SearchBar searchBar;
  List<User> usersList = [];
  Future<List<User>> futureusersList;
  List<Followers> followersList = [];
  Future<List<Followers>> futureFollowersList;

  @override
  void initState() {
    super.initState();
    this.widget.volksPresenter.iVolksView = this;
    this.widget.volksPresenter.doGetUsers();
    this.widget.names = [];
    this.widget.followersnames = [];
  }

  @override
  void UpdateVolksPage(VolksViewModel volksViewModel) {
    setState(() {
      this.usersList = volksViewModel.listUsers;
      // this.followersList = followersViewModel.listFollowers;
      this.widget.names = [];
      this.widget.followersnames = [];
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(
        title: new Text('Find a Volk'),
        backgroundColor: MyColors.UpBarHome,
        actions: [searchBar.getSearchAction(context)]);
  }

  void onSubmitted(String value) {
    showSearch(context: context, delegate: Search(widget.names));

    setState(() => _scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
  }


  _VolksPageHomeState() {
    searchBar = new SearchBar(
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          print("cleared");
        },
        onClosed: () {
          print("closed");
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: searchBar.build(context),
      key: _scaffoldKey,
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          User user = usersList.elementAt(index);
          widget.names.add(usersList[index].username);
          //print(widget.names);
          //showFollowers('malek');

          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OtherProfilePage(user: usersList[index],connectedUser: widget.user,)));
              },
              child: UserCustomWidget(user.first_name, user.username)

            /*ListTile(
                title: Text(
                  usersList[index].username,
                ),
              )*/
          );
        },
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
                title: Text("Messages",style: TextStyle(fontSize:14 ,color: MyColors.secondaryColor )),
              ),

              BottomNavigationBarItem(
                icon: Icon(Icons.home,color: MyColors.secondaryColor),
                title: Text("Home",style: TextStyle(fontSize:14 ,color: MyColors.secondaryColor )),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications,color: MyColors.secondaryColor),
                title: Text("Notifications",style: TextStyle(fontSize:14 ,color: MyColors.secondaryColor )),
              ),

            ],
            onTap: (val) {

              switch (val) {
                case 0:
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VolksPage(this.widget.user),
                      ),
                    );
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
                case 2:
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
        )


    );
  }
}

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  String selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  final List<String> listU;
  Search(this.listU);
  List<String> recentlistU = ["akthem", "malek"];

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestionList = [];

    query.isEmpty
        ? suggestionList = recentlistU
        : suggestionList.addAll(listU.where(
          (element) => element.contains(query),
    ));
    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              suggestionList[index],
            ),
            onTap: () {
              selectedResult = suggestionList[index];

              showResults(context);

              //show profile !!
            },
          );
        });
  }
}