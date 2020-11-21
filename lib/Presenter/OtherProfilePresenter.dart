import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Entity/Followers.dart';
import 'package:volks_demo/Model/Repository/ActivityRepository.dart';
import 'package:volks_demo/Model/Repository/CommentRepository.dart';
import 'package:volks_demo/Model/Repository/FollowersRepository.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/FollowersOtherProfileViewModel.dart';
import 'package:volks_demo/Model/ViewModel/FollowingOtherProfileViewModel.dart';
import 'package:volks_demo/Model/ViewModel/OtherProfileViewModel.dart';
import 'package:volks_demo/Model/ViewModel/PostsOtherProfileViewModel.dart';
import 'package:volks_demo/Views/FollowersOtherProfilePage.dart';
import 'package:volks_demo/Views/FollowingOtherProfilePage.dart';
import 'package:volks_demo/Views/OtherProfilePage.dart';
import 'package:volks_demo/Views/PostsOtherProfilePage.dart';

class IOtherProfilePresenter {

  void doAddFollowers(Followers followers) {}
  void doGetOneFollowers(String username, String following) {}
  void doDeleteFollowers(String username, String following) {}

  void doGetFollowers(String connectedUsername) {}
  void doGetFollowing(String connectedUsername) {}

  void deGetCountFollowers(String connectedUsername){}
  void deGetCountFollowing(String connectedUsername){}
  void doGetCountPosts(String connectedUsername){}

  void doGetPostsUser(String username){}
  void doGetNbCommentFollowerPost(int idPost){}

}

class OtherProfilePresenter implements IOtherProfilePresenter {
  OtherProfileViewModel otherProfileViewModel;
  FollowersRepository followersRepository;
  IOtherProfileView iOtherProfileView;
  ActivityRepository activityRepository;
  UserRepository userRepository;
  FollowersOtherProfileViewModel followersOtherProfileViewModel;
  FollowingOtherProfileViewModel followingOtherProfileViewModel;
  IFollowersOtherProfileView iFollowersOtherProfileView;
  IFollowingOtherProfileView iFollowingOtherProfileView;
  PostRepository postRepository;
  PostOtherProfileViewModel postOtherProfileViewModel;
  IPostOtherProfileView iPostOtherProfileView;
  IPostOtherProfileItemView iPostOtherProfileItemView;
  CommentRepository commentRepository;
  OtherProfilePresenter() {
    commentRepository = CommentRepository();
    postRepository = PostRepository();
    otherProfileViewModel =  OtherProfileViewModel();
    followersRepository =  FollowersRepository();
    activityRepository=  ActivityRepository();
    userRepository = UserRepository();
    followersOtherProfileViewModel = FollowersOtherProfileViewModel();
    followingOtherProfileViewModel = FollowingOtherProfileViewModel();
    postOtherProfileViewModel = PostOtherProfileViewModel();
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

  @override
  void doGetFollowers(String connectedUsername) {

    userRepository.fetchFollows("/followers/getAllFollowers/",[connectedUsername]).then((value){

      this.followersOtherProfileViewModel.followers_list = value;

      this.iFollowersOtherProfileView.UpdateFollowersOtherProfile(followersOtherProfileViewModel);

    });

  }

  @override
  void doGetFollowing(String connectedUsername) {

    userRepository.fetchFollows("/followers/getAllFollowing/",[connectedUsername]).then((value) {
        this.followingOtherProfileViewModel.following_list = value;

        this.iFollowingOtherProfileView.UpdateFollowingOtherProfile(followingOtherProfileViewModel);
    });

  }

  @override
  void deGetCountFollowers(String connectedUsername) {
    
    followersRepository.getCountFollows("/followers/countAllFollowers/",[connectedUsername]).then((value) {

      this.otherProfileViewModel.followers_num = value;
      this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);
    });
  }

  @override
  void deGetCountFollowing(String connectedUsername) {

    followersRepository.getCountFollows("/followers/countAllFollowing/",[connectedUsername]).then((value) {
      print(value);
      this.otherProfileViewModel.following_num = value;
      this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);

    });
  }

  @override
  void doGetPostsUser(String username) {

   this.postOtherProfileViewModel.FuturelistPost = postRepository.fetchUserPosts("/posts/getByUsername/",[username]).then((value) {

      this.postOtherProfileViewModel.listPost = value;
      iPostOtherProfileView.UpdatePostOtherProfileView(postOtherProfileViewModel);

    });


  }

  @override
  void doGetNbCommentFollowerPost(int idPost) {
    commentRepository.getCountComments("/comments/getCountByPost/",[idPost]).then((value) {

      postOtherProfileViewModel.nbComments = value;
      iPostOtherProfileItemView.UpdatePostItemView(postOtherProfileViewModel);

    });

  }

  @override
  void doGetCountPosts(String connectedUsername) {

  postRepository.getCountPosts("/posts/getCountPostByUsername/",[connectedUsername]).then((value) {

    this.otherProfileViewModel.posts_num = value;
    this.iOtherProfileView.updateOtherProfilePage(otherProfileViewModel);

  });


  }


}
