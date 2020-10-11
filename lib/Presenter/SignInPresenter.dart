
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/SignInViewModel.dart';


import '../main.dart';


class IPresenter{


  void doSignIn(String TypedUsername,String TypedPassword)
  {

  }


}


class SignInPresenter implements IPresenter{

  UserRepository userRepository;
  SignInViewModel signInViewModel;
  ILoginView loginView;

  SignInPresenter()
  {
    this.signInViewModel = new SignInViewModel("");
    this.userRepository =  new UserRepository();
  }

  @override
  void doSignIn(String TypedUsername,String TypedPassword) {


    if(!TypedUsername.isEmpty)
    {
      userRepository.getUser("/users/get/",[TypedUsername]).then((value) => {

        if(value ==null)
          {

              this.signInViewModel.Message = "User not found",
              this.loginView.UpdateLoginMessage(this.signInViewModel)

          }else{

            this.signInViewModel.Message = "",
          this.loginView.UpdateLoginMessage(this.signInViewModel),


          if(!TypedPassword.isEmpty)
            {
              if(value.password == TypedPassword){

                this.signInViewModel.Message = "",
                this.loginView.UpdateLoginMessage(this.signInViewModel)

              }else{

                this.signInViewModel.Message = "Wrong password",
                this.loginView.UpdateLoginMessage(this.signInViewModel)

              }
            }else{

              this.signInViewModel.Message = "Password field is required",
              this.loginView.UpdateLoginMessage(this.signInViewModel)
          }

        }

      });
    }else{

      this.signInViewModel.Message = "Username field is required";
      this.loginView.UpdateLoginMessage(this.signInViewModel);

    }

  }



}