import 'package:volks_demo/Model/Repository/RepositoryLocalStorage/UserLSRepository.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/SignInViewModel.dart';
import 'package:volks_demo/Views/SignInPage.dart';

class IPresenter {
  void doTrySignIn(bool RemeberMe,String TypedUsername, String TypedPassword) {}

  void doCheckForRemeberMe()
  {

  }

}

class SignInPresenter implements IPresenter {
  UserRepository userRepository;
  SignInViewModel signInViewModel;
  ILoginView loginView;
  UserLSRepository userLSRepository;

  SignInPresenter() {
    this.signInViewModel = new SignInViewModel(0,"", false);
    this.userRepository = new UserRepository();
    this.userLSRepository= new UserLSRepository();
  }

  @override
  void doTrySignIn(bool RemeberMe,String TypedUsername, String TypedPassword) {

    if(TypedUsername!="" && TypedPassword !="")
      {
        userRepository.getUser("/users/get/", [TypedUsername]).then((value) => {
          if (value == null)
            {
              this.signInViewModel.AccessGranted = false,
              this.signInViewModel.Message = "User Not Found",
              this.signInViewModel.ErrorCode = 1,
              this.loginView.UpdateLoginMessage(this.signInViewModel),

            }
          else
            {
              if (value.password == TypedPassword)
                {

                  if(RemeberMe)
                    {
                      userLSRepository.deleteAll(),
                      userLSRepository.insertUser(value),
                    },

                      this.signInViewModel.AccessGranted = true,
                      this.signInViewModel.ConnectedUser = value,
                      this.signInViewModel.Message = "",
                      this.signInViewModel.ErrorCode = 0,
                      this.loginView.UpdateLoginMessage(this.signInViewModel),

                }
              else
                {

                  this.signInViewModel.AccessGranted = false,
                  this.signInViewModel.Message = "Wrong Password",
                  this.signInViewModel.ErrorCode = 2,
                  this.loginView.UpdateLoginMessage(this.signInViewModel),

                }

            },

        });

      }
  }

  @override
  void doCheckForRemeberMe() {

    UserLSRepository userLSRepository = new UserLSRepository();
    userLSRepository.findAll().then((value) => {
      if(value.length != 0)
        {
          this.signInViewModel.UserRemebered = value[0],
          this.loginView.UpdateRemeberedUser(signInViewModel)
        }
    });

  }




}
