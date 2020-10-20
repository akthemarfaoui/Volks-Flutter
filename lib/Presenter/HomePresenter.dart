import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/Repository/RepositoryLocalStorage/UserLSRepository.dart';
import 'package:volks_demo/Model/ViewModel/HomeViewModel.dart';
import 'package:volks_demo/Views/HomePage.dart';

class IHomePresenter
{

  void doGetPosts()
  {


  }
  void doLogout() {


  }

}


class HomePresenter implements IHomePresenter{

HomeViewModel homeViewModel;
IHomeView iHomeView;
PostRepository postRepository;
UserLSRepository userLSRepository;

HomePresenter()
{
 homeViewModel=new HomeViewModel(true);
 postRepository = new PostRepository();
 userLSRepository = new UserLSRepository();
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

@override
void doLogout() {

  userLSRepository.deleteAll();

}
}