


import 'package:volks_demo/Model/Entity/Post.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/ViewModel/HomeViewModel.dart';
import 'package:volks_demo/Views/HomePage.dart';

class IHomePresenter
{

  void doGetPosts()
  {


  }

}


class HomePresenter implements IHomePresenter{

HomeViewModel homeViewModel;
IHomeView iHomeView;
PostRepository postRepository;

HomePresenter()
{
 homeViewModel=new HomeViewModel(true);
 postRepository = new PostRepository();
}
  @override
  void doGetPosts() {

  this.homeViewModel.loading = true;

  this.homeViewModel.FuturelistPost=postRepository.fetchPosts("/posts/getAll/").then((value){

      this.homeViewModel.listPost = value;
      this.homeViewModel.loading = false;
      iHomeView.UpdateSignUpPage(this.homeViewModel);

    });

  iHomeView.UpdateSignUpPage(this.homeViewModel);

  }

}