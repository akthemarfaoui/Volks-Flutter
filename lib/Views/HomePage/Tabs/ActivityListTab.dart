import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/ActivityViewModel.dart';
import 'package:volks_demo/Presenter/ActivityPresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';

class IActivityView {
  void UpdateActivityListTab(ActivityViewModel activityViewModel) {}
}

class ActivityListTab extends StatefulWidget {
  User user;

  final activityPresenter = new ActivityPresenter();

  ActivityListTab({this.user});

  @override
  State<StatefulWidget> createState() => ActivityListTabState();
}

class ActivityListTabState extends State<ActivityListTab>
    implements IActivityView {
  List<Activity> activityList = [];
  Future<List<Activity>> factivityList;

  @override
  void UpdateActivityListTab(ActivityViewModel activityViewModel) {
    setState(() {
      this.activityList = activityViewModel.listActivity;
      this.factivityList = activityViewModel.FuturelistActivity;
    });
  }

  Future<List<Activity>> getData() async {
    this.widget.activityPresenter.doGetActivities(widget.user.username);
    return this.factivityList;
  }

  bool loading = true;

  @override
  void initState() {
    super.initState();

    this.widget.activityPresenter.iActivityView = this;

    // this.widget.homePresenter.doGetPosts();
    getData().then((d) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  void didUpdateWidget(ActivityListTab oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    this.widget.activityPresenter.iActivityView = this;
    //this.widget.homePresenter.doGetPosts();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          backgroundColor: Theme.of(context).buttonColor,
          body: !loading
              ? RefreshIndicator(
                  onRefresh: () async {
                    activityList.clear();
                    await getData();
                  },
                  child: ActivityListView(list: activityList),
                )
              : Center(
                  child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          MyColors.PostColor)),
                ),
        ),
        onWillPop: () async => false);
  }
}

class ActivityListView extends StatefulWidget {
  const ActivityListView({
    Key key,
    this.list,
  }) : super(key: key);
  final List<Activity> list;

  @override
  ActivityListViewState createState() {
    return new ActivityListViewState();
  }
}

class ActivityListViewState extends State<ActivityListView> {
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
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Stack(
                    children: <Widget>[
                      ActivityItemView(item: item)
                      /*UserAvatar(
                  height: 50.0,
                  width: 50.0,
                  username: item.username,
                ),*/
                    ],
                  ),
                );
              }).toList()
            : []);
  }
}

class ActivityItemView extends StatefulWidget {
  ActivityItemView({
    Key key,
    this.item,
  }) : super(key: key);

  final Activity item;

  @override
  ActivityItemViewState createState() {
    return ActivityItemViewState();
  }
}

class ActivityItemViewState extends State<ActivityItemView>
    with SingleTickerProviderStateMixin {

  String activity = "";


  @override
  void initState() {
    super.initState();

    if(widget.item.type == "POST")
      {

        activity = " Shared a post";

      }else if( widget.item.type == "FOLLOW")
        {

          activity = " Follow "+widget.item.actWith;

        }else if(widget.item.type == "COMMENT")
          {
            activity = " Commented a post";
          }

  }

  @override
  Widget build(BuildContext context) {
    return Card(

        color: Colors.white,
        elevation: 2.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        child: Padding(
          padding: EdgeInsets.only(top:20,bottom: 20, left: 10, right: 20),
          child: Container(
            height: 70,
            color: Colors.white,
            child: ListTile(
              title: RichText(
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                    children: [
                      TextSpan(
                        text: widget.item.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: activity ),
                    ]),
              ),
              leading: new Container(
                width: 50,
                height: 50,
                child: ClipOval(child: getProfileImage(widget.item.username)),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(width: 1.0, color: Colors.transparent)),
              ),
              subtitle: Text(
                "26/10/2020",
                style: TextStyle(fontSize: 18),overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ));
  }
}
