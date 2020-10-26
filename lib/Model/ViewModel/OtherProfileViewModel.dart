import 'package:volks_demo/Model/Entity/Followers.dart';

class OtherProfileViewModel
{
  List<Followers> listFollowers;
  bool isFollowing = false;
  bool didSuccessfullyAdded = false;
  bool didSuccessffullyDeleted = false;
  bool statusChanged = false;
  Future<List<Followers>> futurelistFollowers;

}