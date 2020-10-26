import 'package:volks_demo/Model/Entity/Activity.dart';
import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Repository/ActivityRepository.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/ViewModel/AddPostViewModel.dart';
import 'package:volks_demo/Views/AddPostPage.dart';

class IAddPostPresenter {
  void doAddPost(String Username, String Description) {}
}

class AddPostPresenter implements IAddPostPresenter {
  AddPostViewModel addPostViewModel;
  IAddPostView iAddPostView;

  PostRepository postRepository;
  ActivityRepository activityRepository;

  AddPostPresenter() {
    addPostViewModel = new AddPostViewModel("");
    postRepository = new PostRepository();
    activityRepository = new ActivityRepository();
  }

  @override
  void doAddPost(String Username, String Description) {
    bool accessGranted = false;

    if (Description != "") {
      accessGranted = true;
    } else {
      this.addPostViewModel.ErrorMessage = "Description field is required";
      this.iAddPostView.UpdatePostPage(this.addPostViewModel);
    }

    if (accessGranted) {
      Post post = new Post.AnotherCtor(Username, Description);

      postRepository
          .addPost("/posts/add/", post)
          .then((value) {

            Activity activity = new Activity();
            activity.type = "POST";
            activity.username = post.username;
            activity.actWith = value.toString();
            activityRepository.addActivity("/activity/add/", activity);

          });

    }
  }
}
