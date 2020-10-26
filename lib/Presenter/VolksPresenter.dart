import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/FollowersViewModel.dart';
import 'package:volks_demo/Model/ViewModel/VolksViewModel.dart';
import 'package:volks_demo/Views/VolksPage.dart';

class IVolksPresenter {
  void doGetUsers() {}
}

class VolksPresenter implements IVolksPresenter {
  VolksViewModel volksViewModel;
  FollowersViewModel followersViewModel;
  UserRepository userRepository;
  IVolksView iVolksView;

  VolksPresenter() {
    volksViewModel = new VolksViewModel();
    userRepository = new UserRepository();
  }
  @override
  void doGetUsers() {
    this.volksViewModel.futurelistUsers =
        userRepository.fetchUsers("/users/getAll/").then((value) {
      this.volksViewModel.listUsers = value;
      iVolksView.UpdateVolksPage(volksViewModel);
    });
  }
}
