import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/SignUpViewModel.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Views/SignUpPage.dart';

class ISignUpPresenter{

Future<int> doSignUp(var value,var dateTime,String Username ,String Password, String ConfirmPassword)
{

}

void doCheckUsernameExist(String Username)
{

}

}


class SignUpPresenter implements ISignUpPresenter
{

  SignUpViewModel signUpViewModel;
  ISignUpView signUpView;

  UserRepository userRepository;

  SignUpPresenter()
  {
    signUpViewModel = new SignUpViewModel(0,"");
    userRepository=new UserRepository();
  }

  @override
  Future<int> doSignUp(var value,var dateTime,String Username ,String Password, String ConfirmPassword) {

    User user = new User.AnotherCtor(Username, Password, value, getFormatedDate(dateTime));
    return userRepository.addUser("/users/add/", user);

  }

  @override
  void doCheckUsernameExist(String Username) {

    if(Username != "")
      {

        userRepository.getUser("/users/get/",[Username]).then((value) => {

          if(value !=null)
            {

              this.signUpViewModel.ErrorMessage = "Username Already Exist !",
              this.signUpViewModel.ErrorCode = 1,
              this.signUpView.UpdateSignUpPage(this.signUpViewModel),

            }else{

              this.signUpViewModel.ErrorMessage = "",
              this.signUpViewModel.ErrorCode = 0,
              this.signUpView.UpdateSignUpPage(this.signUpViewModel),

          }
        });

      }


  }




}