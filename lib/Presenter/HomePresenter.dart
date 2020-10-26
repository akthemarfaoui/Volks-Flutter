import 'package:volks_demo/Model/Repository/CommentRepository.dart';
import 'package:volks_demo/Model/Repository/PostRepository.dart';
import 'package:volks_demo/Model/Repository/RepositoryLocalStorage/UserLSRepository.dart';
import 'package:volks_demo/Model/ViewModel/HomeViewModel.dart';
import 'package:volks_demo/Views/HomePage/Tabs/PostListTab.dart';

class IHomePresenter
{

  void doGetPosts()
  {


  }

  void doGetNbComment(int idPost)
  {

  }
  void doLogout() {


  }

}


class HomePresenter implements IHomePresenter{

HomeViewModel homeViewModel;
IHomeView iHomeView;
IPostItemView iPostItemView;
PostRepository postRepository;
CommentRepository commentRepository;
UserLSRepository userLSRepository;

HomePresenter()
{
 homeViewModel=new HomeViewModel(true);
 postRepository = new PostRepository();
 userLSRepository = new UserLSRepository();
 commentRepository = new CommentRepository();
}

@override
void doGetNbComment(int idPost) {
  commentRepository.getCountComments("/comments/getCountByPost/",[idPost]).then((value) {

    homeViewModel.nbComments = value;
    iPostItemView.UpdatePostItemView(homeViewModel);

  });

}


  @override
  void doGetPosts() {

  this.homeViewModel.loading = true;

  this.homeViewModel.FuturelistPost=postRepository.fetchPosts("/posts/getAll/").then((value){

      this.homeViewModel.listPost = value;
      this.homeViewModel.loading = false;
      iHomeView.UpdateHomePage(this.homeViewModel);

    });

  iHomeView.UpdateHomePage(this.homeViewModel);

  }

@override
void doLogout() {

  userLSRepository.deleteAll();

}


}