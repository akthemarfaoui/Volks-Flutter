import 'package:volks_demo/Model/Entity/Post.dart';

class HomeViewModel
{

  List<Post> listPost;
  Future<List<Post>> FuturelistPost;
  bool loading;
  HomeViewModel(this.loading);
}

