import 'package:volks_demo/API/GeoCoding.dart';
import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Repository/ActivityRepository.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/ViewModel/AddPostViewModel.dart';
import 'package:volks_demo/Views/AddPostPage.dart';

class IAddPostPresenter {
  void doAddPost(String Username, String Description,bool withPosition) {}
}

class AddPostPresenter implements IAddPostPresenter {
  AddPostViewModel addPostViewModel;
  IAddPostView iAddPostView;

  PostRepository postRepository;
  ActivityRepository activityRepository;
  GeoCoding geoCoding;

  AddPostPresenter() {
    geoCoding = new GeoCoding();
    addPostViewModel = new AddPostViewModel(false,true);
    postRepository = new PostRepository();
    activityRepository = new ActivityRepository();
  }

  @override
  void doAddPost(String Username, String Description,bool withPosition) {

    Post post;
    this.addPostViewModel.loading = true;
    this.addPostViewModel.didAddedSuccessfully = false;
    this.iAddPostView.UpdatePostPage(addPostViewModel);

      if(withPosition)
        {

          geoCoding.getCurrentPosition().then((valuePos) {
            geoCoding.reverseGeocode(valuePos.latitude, valuePos.longitude).then((pos) {

              String position = pos.first.subLocality+", "+pos.first.locality+", "+pos.first.country;

              post = new Post.AddWithPosition(Username, Description, valuePos.latitude.toString(), valuePos.longitude.toString(), position);
              postRepository.addPost("/posts/add/", post)
                  .then((value) {

                Activity activity = new Activity();
                activity.type = "POST";
                activity.username = post.username;
                activity.actWith = value.toString();
                activityRepository.addActivity("/activity/add/", activity);
                this.addPostViewModel.didAddedSuccessfully = true;
                this.addPostViewModel.loading = false;
                this.iAddPostView.UpdatePostPage(addPostViewModel);

              });

            });

          });

        }else{

         post = new Post.AddWithoutPosition(Username, Description);

         postRepository.addPost("/posts/add/", post)
             .then((value) {

           Activity activity = new Activity();
           activity.type = "POST";
           activity.username = post.username;
           activity.actWith = value.toString();
           activityRepository.addActivity("/activity/add/", activity);
           this.addPostViewModel.didAddedSuccessfully = true;
           this.addPostViewModel.loading = false;
           this.iAddPostView.UpdatePostPage(addPostViewModel);

         });
      }

  }
}
