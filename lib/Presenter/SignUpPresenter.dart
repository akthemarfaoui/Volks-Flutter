import 'package:intl/intl.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/Repository/UserRepository.dart';
import 'package:volks_demo/Model/ViewModel/SignUpViewModel.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Views/SignUpPage.dart';

import '../main.dart';
import '../main.dart';

class ISignUpPresenter{

void doSignUp(var value,var dateTime,String Username ,String Password, String ConfirmPassword)
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
    signUpViewModel = new SignUpViewModel("");
    userRepository=new UserRepository();
  }

  @override
  void doSignUp(var value,var dateTime,String Username ,String Password, String ConfirmPassword) {

    bool accessGranted = false;

    if(Username != ""  )
    {
      if(Password!="")
      {
        if(ConfirmPassword !="")
        {
          if(dateTime != null)
          {
           if(value !=null)
             {
               if(Password == ConfirmPassword)
               {

                 accessGranted = true;

               }else{

                 this.signUpViewModel.ErrorMessage = "Confirm Password & Password doesnt match !";
                 this.signUpView.UpdateSignUpPage(this.signUpViewModel);

               }

             }else{
             this.signUpViewModel.ErrorMessage = "Gender field is required";
             this.signUpView.UpdateSignUpPage(this.signUpViewModel);
           }

          }else{
            this.signUpViewModel.ErrorMessage = "Birth date field is required";
            this.signUpView.UpdateSignUpPage(this.signUpViewModel);
          }
        }else{
          this.signUpViewModel.ErrorMessage = "Confirm Password field is required";
          this.signUpView.UpdateSignUpPage(this.signUpViewModel);
        }

      }else{
        this.signUpViewModel.ErrorMessage = "Password field is required";
        this.signUpView.UpdateSignUpPage(this.signUpViewModel);
      }

    }else{

      this.signUpViewModel.ErrorMessage = "Username field is required";
      this.signUpView.UpdateSignUpPage(this.signUpViewModel);
    }



if(accessGranted)
  {

    String sexe ="";

    if(value == 1)
    {

      sexe = "Female";

    }else if(value == 2)
    {

      sexe = "Male";

    }

    this.signUpViewModel.ErrorMessage = "";
    this.signUpView.UpdateSignUpPage(this.signUpViewModel);

    User user = new User.AnotherCtor(Username, Password, sexe, getFormatedDate(dateTime));

    userRepository.getUser("/users/get/",[user.username]).then((value) => {

      if(value !=null)
        {

        this.signUpViewModel.ErrorMessage = "Username already exist !",
        this.signUpView.UpdateSignUpPage(this.signUpViewModel),

        }else{
        userRepository.addUser("/users/add/", user).then((value) => print("id => "+value.toString())),
        }
    });

  }

  }




}