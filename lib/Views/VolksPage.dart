import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/VolksViewModel.dart';
import 'package:volks_demo/Presenter/VolksPresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/CustomWidget/UserCustomWidget.dart';

class IVolksView {
  void UpdateVolksPage(VolksViewModel volksViewModel) {}
}

class VolksPage extends StatefulWidget {
  User user;
  final volksPresenter = new VolksPresenter();

  @override
  _VolksPageHomeState createState() => new _VolksPageHomeState();
}

class _VolksPageHomeState extends State<VolksPage> implements IVolksView {
  SearchBar searchBar;
  List<User> usersList = [];
  Future<List<User>> futureusersList;

  @override
  void initState() {
    super.initState();
    this.widget.volksPresenter.iVolksView = this;
    this.widget.volksPresenter.doGetUsers();
  }

  @override
  void UpdateVolksPage(VolksViewModel volksViewModel) {
    setState(() {
      this.usersList = volksViewModel.listUsers;
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
    showSearch(context: context, delegate: Search(usersList));

    // setState(() => _scaffoldKey.currentState
    //  .showSnackBar(new SnackBar(content: new Text('You wrote $value!'))));
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
        /* itemCount: usersList.length,
        itemBuilder: (BuildContext context, int index) {
          User user = usersList.elementAt(index);

          return GestureDetector(
              onTap: () {
                //  Navigator.push(context, MaterialPageRoute(builder: (context) => ));
              },
              child: UserCustomWidget(user.first_name, user.username));
        },
*/
        itemCount: usersList.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            usersList[index].username,
          ),
        ),
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

  final List<User> listU;
  Search(this.listU);
  List<User> recentlistU;

  @override
  Widget buildSuggestions(BuildContext context) {
    List<User> suggestionList = [];
    query.isEmpty
        ? suggestionList = recentlistU
        : suggestionList.addAll(listU.where(
            (element) => element.username.contains(query),
          ));
    return ListView.builder(
        //itemCount: suggestionList.length,
        itemBuilder: (context, index) {
      return ListTile(
        title: Text(
          suggestionList[index].username,
        ),
        onTap: () {
          selectedResult = suggestionList[index].username;
          showResults(context);
        },
      );
    });
  }
}
