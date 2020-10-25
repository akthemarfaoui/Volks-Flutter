import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Entity/followers.dart';
import 'package:volks_demo/Model/ViewModel/FollowersViewModel.dart';
import 'package:volks_demo/Model/ViewModel/VolksViewModel.dart';
import 'package:volks_demo/Presenter/FollowersPresenter.dart';
import 'package:volks_demo/Presenter/VolksPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/CustomWidget/UserCustomWidget.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';
import 'package:volks_demo/Views/ProfilePage.dart';

class IVolksView {
  void UpdateVolksPage(VolksViewModel volksViewModel) {}
}

class VolksPage extends StatefulWidget {
  User user;
  final volksPresenter = new VolksPresenter();
  final followersPresenter = new FollowersPresenter();
  List<String> names = [];
  List<String> followersnames = [];
  VolksPage();

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

  void showFollowers(String name) {
    this.widget.followersPresenter.doGetFollowers(name);
    for (var i = 0; i < followersList.length; i++) {
      print(followersList[i].following);
    }
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
                            OtherProfilePage(usersList[index])));
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
