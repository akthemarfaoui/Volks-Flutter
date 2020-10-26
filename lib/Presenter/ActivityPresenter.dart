

import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Repository/ActivityRepository.dart';
import 'package:volks_demo/Model/ViewModel/ActivityViewModel.dart';
import 'package:volks_demo/Views/HomePage/Tabs/ActivityListTab.dart';

class IActivityPresenter{

  void doAddActivity(Activity activity)
  {

  }

  void doGetActivities(String username)
  {

  }
}

class ActivityPresenter implements IActivityPresenter{

  ActivityViewModel activityViewModel;
  IActivityView iActivityView;
  ActivityRepository activityRepository;

  ActivityPresenter()
  {
    activityViewModel=new ActivityViewModel(true);
    activityRepository = new ActivityRepository();
  }

  @override
  void doGetActivities(String username) {

    this.activityViewModel.loading = true;

    this.activityViewModel.FuturelistActivity = activityRepository.fetchActivities("/activity/getAllByFollowing/",[username]).then((value){
      print(value);
      this.activityViewModel.listActivity = value;
      this.activityViewModel.loading = false;
      iActivityView.UpdateActivityListTab(activityViewModel);

    });

    iActivityView.UpdateActivityListTab(activityViewModel);

  }

  @override
  void doAddActivity(Activity activity) {

    activityRepository.addActivity("/activity/add/", activity).then((value) {



    });

  }



}