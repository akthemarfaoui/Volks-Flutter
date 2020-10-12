import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/ViewModel/PostViewModel.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Views/homepage.dart';

class IPostPresenter {
  void doAddPost(String Username, String Description) {}
}

class PostPresenter implements IPostPresenter {
  PostViewModel postViewModel;
  IPostView postView;

  PostRepository postRepository;

  PostPresenter() {
    postViewModel = new PostViewModel("");
    postRepository = new PostRepository();
  }

  @override
  void doAddPost(String Username, String Description) {
    bool accessGranted = false;

    if (Description != "") {
      accessGranted = true;
    } else {
      this.postViewModel.ErrorMessage = "Description field is required";
      this.postView.UpdatePostPage(this.postViewModel);
    }

    if (accessGranted) {
      Post post = new Post.AnotherCtor(Username, Description);

      postRepository
          .addPost("/posts/add/", post)
          .then((value) => print("id => " + value.toString()));
    }
  }
}
