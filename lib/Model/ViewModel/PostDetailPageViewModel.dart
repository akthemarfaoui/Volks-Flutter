import 'package:volks_demo/Model/Entity/Comment.dart';

class PostDetailPageViewModel
{

  List<Comment> listComment;
  Future<List<Comment>> FuturelistComment;
  bool loading;
  int ErrorCode;
  bool successfullyInserted = false;

  PostDetailPageViewModel(this.loading);
  PostDetailPageViewModel.AddComment(this.ErrorCode);

}