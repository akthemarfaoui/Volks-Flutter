import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/SignInViewModel.dart';
import 'package:volks_demo/Views/SignInPage.dart';

class IPresenter {
  void doSignIn(String TypedUsername, String TypedPassword) {}
}

class SignInPresenter implements IPresenter {
  UserRepository userRepository;
  SignInViewModel signInViewModel;
  ILoginView loginView;

  SignInPresenter() {
    this.signInViewModel = new SignInViewModel("", false);
    this.userRepository = new UserRepository();
  }

  @override
  void doSignIn(String TypedUsername, String TypedPassword) {
    print(TypedUsername);
    print(TypedPassword);

    if (!TypedUsername.isEmpty) {
      userRepository.getUser("/users/get/", [TypedUsername]).then((value) => {
            if (value == null)
              {
                this.signInViewModel.Message = "User not found",
                this.signInViewModel.AccessGranted = false,
                this.loginView.UpdateLoginMessage(this.signInViewModel),
              }
            else
              {
                if (!TypedPassword.isEmpty)
                  {
                    if (value.password == TypedPassword)
                      {
                        this.signInViewModel.AccessGranted = true,
                        this.signInViewModel.ConnectedUser = value,
                        this.signInViewModel.Message = "",
                        this.loginView.UpdateLoginMessage(this.signInViewModel)
                      }
                    else
                      {
                        this.signInViewModel.AccessGranted = false,
                        this.signInViewModel.Message = "Wrong password",
                        this.loginView.UpdateLoginMessage(this.signInViewModel)
                      }
                  }
                else
                  {
                    this.signInViewModel.AccessGranted = false,
                    this.signInViewModel.Message = "Password field is required",
                    this.loginView.UpdateLoginMessage(this.signInViewModel)
                  }
              }
          });
    } else {
      this.signInViewModel.AccessGranted = false;
      this.signInViewModel.Message = "Username field is required";
      this.loginView.UpdateLoginMessage(this.signInViewModel);
    }
  }
}
