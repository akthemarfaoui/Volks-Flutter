import 'package:volks_demo/Model/Entity/Followers.dart';

class OtherProfileViewModel
{
  List<Followers> listFollowers;
  bool isFollowing = false;
  bool didSuccessfullyAdded = false;
  bool didSuccessffullyDeleted = false;
  bool statusChanged = false;
  Future<List<Followers>> futurelistFollowers;

  int following_num=0;
  int followers_num=0;
  int posts_num=0;

}