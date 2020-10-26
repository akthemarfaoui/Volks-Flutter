
import 'package:volks_demo/Model/Entity/Activity.dart';

class ActivityViewModel
{

  List<Activity> listActivity;
  Future<List<Activity>> FuturelistActivity;
  bool loading;
  ActivityViewModel(this.loading);
}
