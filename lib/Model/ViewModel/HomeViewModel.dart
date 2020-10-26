import 'package:volks_demo/Model/Entity/Post.dart';

class HomeViewModel
{

  List<Post> listPost;
  Future<List<Post>> FuturelistPost;
  bool loading;
  int nbComments = 0;
  HomeViewModel(this.loading);
}

