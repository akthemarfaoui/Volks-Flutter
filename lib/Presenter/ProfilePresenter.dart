import 'dart:io';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/ProfileViewModel.dart';
import 'package:volks_demo/Views/ProfilePage.dart';

class IProfilePresenter{

void doUpdateUser(User user)
{

}

void doUploadImage(String username,File file)
{

}

}

class ProfilePresenter implements IProfilePresenter {

  UserRepository userRepository;
  ProfileViewModel profileViewModel;
  IPofileView iPofileView;
  ProfilePresenter()
  {
    userRepository = new UserRepository();
    profileViewModel = new ProfileViewModel(false);
  }

  @override
  void doUpdateUser(User user) {

    userRepository.updateUser("/users/update", user).then((value) {

      if(value==200)
        {
          this.profileViewModel.didUpdated= true;
          iPofileView.UpdateProfilePage(profileViewModel);
        }

    });

  }

  @override
  void doUploadImage(String username, File file) {

    userRepository.uploadProfileImage("uploads/profileimage",username, file).then((value) => {

      if(value.body=="OK")
        {

        this.profileViewModel.didUpdated= true,
        iPofileView.UpdateProfilePage(profileViewModel),

        }

    });

  }







}