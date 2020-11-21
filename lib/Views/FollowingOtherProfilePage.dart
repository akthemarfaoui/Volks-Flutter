

import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/FollowingOtherProfileViewModel.dart';
import 'package:volks_demo/Presenter/OtherProfilePresenter.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/CustomWidget/UserCustomWidget.dart';
import 'package:volks_demo/Views/HomePage/HomePage.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';
import 'package:volks_demo/Views/ProfilePage.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class IFollowingOtherProfileView {
  void UpdateFollowingOtherProfile(FollowingOtherProfileViewModel followingOtherProfileViewModel) {}
}

class FollowingOtherProfilePage extends StatefulWidget {

  OtherProfilePresenter otherProfilePresenter = OtherProfilePresenter();
  User user;
  int count;
  FollowingOtherProfilePage({this.user,this.count});

  @override
  FollowingOtherProfileState createState() => new FollowingOtherProfileState();
}

class FollowingOtherProfileState extends State<FollowingOtherProfilePage> implements IFollowingOtherProfileView {
  List<User> usersList = [];
  Future<List<User>> futureusersList;

  @override
  void initState() {
    super.initState();
    this.widget.otherProfilePresenter.iFollowingOtherProfileView = this;
    this.widget.otherProfilePresenter.doGetFollowing(this.widget.user.username);

  }

  @override
  void UpdateFollowingOtherProfile(FollowingOtherProfileViewModel followingOtherProfileViewModel) {

    setState(() {
      this.usersList = followingOtherProfileViewModel.following_list;
    });

  }


  @override
  void didUpdateWidget(FollowingOtherProfilePage oldWidget) {
    // TODO: implement didUpdateWidget
    this.widget.otherProfilePresenter.iFollowingOtherProfileView = this;

    super.didUpdateWidget(oldWidget);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        appBar: AppBar(title: Center(child: Text("Followers ("+this.widget.count.toString()+")"),),),

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