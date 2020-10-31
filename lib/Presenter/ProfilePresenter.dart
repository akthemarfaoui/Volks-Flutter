import 'dart:io';
import 'package:volks_demo/API/GeoCoding.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/ProfileViewModel.dart';
import 'package:volks_demo/Views/ProfilePage.dart';

class IProfilePresenter {
  void doUpdateUser(User user) {}

  void doUploadImage(String username, File file) {}
  void doFindMyAdress() {}
}

class ProfilePresenter implements IProfilePresenter {
  UserRepository userRepository;
  ProfileViewModel profileViewModel;
  IPofileView iPofileView;
  GeoCoding geoCoding;
  ProfilePresenter() {
    userRepository = new UserRepository();
    profileViewModel = new ProfileViewModel(false, "", false);
    geoCoding = GeoCoding();
  }

  @override
  void doUpdateUser(User user) {
    userRepository.updateUser("/users/update", user).then((value) {
      if (value == 200) {
        this.profileViewModel.didUpdated = true;
        iPofileView.UpdateProfilePage(profileViewModel);
      }
    });
  }

  @override
  void doFindMyAdress() {
    this.profileViewModel.findAdressLoading = true;
    this.iPofileView.UpdateProfilePage(profileViewModel);
    geoCoding.getCurrentPosition().then((valuePos) {
      geoCoding
          .reverseGeocode(valuePos.latitude, valuePos.longitude)
          .then((pos) {
        String position = pos.first.subLocality +
            ", " +
            pos.first.locality +
            ", " +
            pos.first.country;

        this.profileViewModel.findAdressLoading = false;
        this.profileViewModel.myAdress = position;
        this.iPofileView.UpdateProfilePage(profileViewModel);
      });
    });
  }

  @override
  void doUploadImage(String username, File file) {
    userRepository
        .uploadProfileImage("uploads/profileimage", username, file)
        .then((value) => {
              if (value.body == "OK")
                {
                  this.profileViewModel.didUpdated = true,
                  iPofileView.UpdateProfilePage(profileViewModel),
                }
            });
  }
}
