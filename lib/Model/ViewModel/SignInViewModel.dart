

import 'package:volks_demo/Model/Entity/User.dart';

class SignInViewModel
{
String Message;
bool AccessGranted;
User ConnectedUser;
int ErrorCode;

SignInViewModel(this.ErrorCode,this.Message,this.AccessGranted);
}