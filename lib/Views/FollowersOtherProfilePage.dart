import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/FollowersOtherProfileViewModel.dart';
import 'package:flutter/material.dart';
import 'package:volks_demo/Presenter/OtherProfilePresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/CustomWidget/UserCustomWidget.dart';
import 'package:volks_demo/Views/HomePage/HomePage.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';
import 'package:volks_demo/Views/ProfilePage.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class IFollowersOtherProfileView {
  void UpdateFollowersOtherProfile(FollowersOtherProfileViewModel followersOtherProfileViewModel) {}
}

class FollowersOtherProfilePage extends StatefulWidget {

  OtherProfilePresenter otherProfilePresenter = OtherProfilePresenter();
  User user;
  int count;
  FollowersOtherProfilePage({this.user,this.count});

  @override
  FollowersOtherProfileState createState() => new FollowersOtherProfileState();
}

class FollowersOtherProfileState extends State<FollowersOtherProfilePage> implements IFollowersOtherProfileView {
  List<User> usersList = [];
  Future<List<User>> futureusersList;

  @override
  void initState() {
    super.initState();
    this.widget.otherProfilePresenter.iFollowersOtherProfileView = this;
    this.widget.otherProfilePresenter.doGetFollowers(this.widget.user.username);

  }
  @override
  void didUpdateWidget(FollowersOtherProfilePage oldWidget) {
    // TODO: implement didUpdateWidget
    this.widget.otherProfilePresenter.iFollowersOtherProfileView = this;

    super.didUpdateWidget(oldWidget);
  }

  @override
  void UpdateFollowersOtherProfile(FollowersOtherProfileViewModel followersOtherProfileViewModel) {

    setState(() {
      this.usersList = followersOtherProfileViewModel.followers_list;
    });

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Center(child: Text("Following ("+this.widget.count.toString()+")"),),),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: usersList.length,
          itemBuilder: (BuildContext context, int index) {
            User user = usersList.elementAt(index);

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