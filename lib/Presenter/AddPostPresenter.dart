import 'package:volks_demo/Model/Entity/Post.dart';
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

  AddPostPresenter() {
    addPostViewModel = new AddPostViewModel("");
    postRepository = new PostRepository();
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
          .then((value) => print("id => " + value.toString()));
    }
  }
}
