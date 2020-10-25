import 'package:volks_demo/Model/Repository/FollowersRepository.dart';
import 'package:volks_demo/Model/ViewModel/FollowersViewModel.dart';
import 'package:volks_demo/Model/ViewModel/VolksViewModel.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class IFollowersPresenter {
  void doGetFollowers(String username) {}
}

class FollowersPresenter implements IFollowersPresenter {
  FollowersViewModel followersViewModel;
  FollowersRepository followersRepository;
  IVolksView iVolksView;

  //IFollowersView iFollowersView;

  FollowersPresenter() {
    followersViewModel = new FollowersViewModel();
    followersRepository = new FollowersRepository();
  }

  @override
  void doGetFollowers(String username) {
    this.followersViewModel.futurelistFollowers = followersRepository
        .fetchFollowers("/followers/getAllFollowers/", [username]).then(
            (value) {
      // this.followersViewModel.listFollowers = value;
    });
  }
}
