import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Entity/Followers.dart';
import 'package:volks_demo/Model/Repository/ActivityRepository.dart';
import 'package:volks_demo/Model/Repository/FollowersRepository.dart';
import 'package:volks_demo/Model/ViewModel/OtherProfileViewModel.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';

class IOtherProfilePresenter {
  void doAddFollowers(Followers followers) {}
  void doGetOneFollowers(String username, String following) {}
  void doDeleteFollowers(String username, String following) {}
}

class OtherProfilePresenter implements IOtherProfilePresenter {
  OtherProfileViewModel otherProfileViewModel;
  FollowersRepository followersRepository;
  IOtherProfileView iOtherProfileView;
  ActivityRepository activityRepository;
  OtherProfilePresenter() {
    otherProfileViewModel = new OtherProfileViewModel();
    followersRepository = new FollowersRepository();
    activityRepository= new ActivityRepository();
  }
/*
  @override
  void doGetFollowers(String username) {
    this.followersViewModel.futurelistFollowers = followersRepository
        .fetchFollowers("/followers/getAllFollowers/", [username]).then((value) {

    });
  }
*/
  @override
  void doGetOneFollowers(String username, String following) {
    followersRepository.getOneFollowers(
        "/followers/getOne/", [username, following]).then((value) {
      if (value == null) {

        this.otherProfileViewModel.isFollowing = false;
        this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);

      } else {

        this.otherProfileViewModel.isFollowing = true;
        this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);
      }
      //iOtherProfileView.updateOtherProfilePage(this.otherProfileViewModel);
    });
  }


  @override
  void doAddFollowers(Followers followers) {
    this.followersRepository.addFollowers("/followers/add", followers).then((value) {

      print(value);
      if(value=="Ok")
      { 
        this.otherProfileViewModel.didSuccessfullyAdded = true;
        this.otherProfileViewModel.didSuccessffullyDeleted= false;
        this.otherProfileViewModel.statusChanged = true;
        Activity activity = new Activity();
        activity.username = followers.username;
        activity.actWith = followers.following;
        activity.type = "FOLLOW";
        activityRepository.addActivity("/activity/add/", activity);

        this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);
      }else{
        this.otherProfileViewModel.didSuccessfullyAdded =false;
        this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);

      }


    });
  }

  @override
  void doDeleteFollowers(String username, String following) {
    this.followersRepository.deleteFollowers("/followers/delete/",[username,following]).then((value){

      if(value=="Ok")
        {
          this.otherProfileViewModel.didSuccessffullyDeleted = true;
          this.otherProfileViewModel.didSuccessfullyAdded = false;
          this.otherProfileViewModel.statusChanged = true;
          this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);
        }else{
          this.otherProfileViewModel.didSuccessffullyDeleted = false;
          this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);
      }

    });
  }
}
