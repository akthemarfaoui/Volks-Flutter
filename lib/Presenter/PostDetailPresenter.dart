import 'package:volks_demo/Model/Entity/Comment.dart';
import 'package:volks_demo/Model/Repository/CommentRepository.dart';
import 'package:volks_demo/Model/ViewModel/PostDetailPageViewModel.dart';
import 'package:volks_demo/Views/PostDetailPage/PostDetailPage.dart';
import 'package:volks_demo/Views/PostDetailPage/Tabs/CommentPageTab.dart';

class IPostDetailPresenter
{
  void doGetComments(int idPost)
  {

  }

  void doAddComment(Comment comment)
  {

  }
}

class PostDetailPresenter implements IPostDetailPresenter
{
  PostDetailPageViewModel postDetailPageViewModel;
  IPostDetailPage iPostDetailView;
  ICommentPageTab iCommentPageTab;
  CommentRepository commentRepository;

  PostDetailPresenter()
  {
    postDetailPageViewModel = PostDetailPageViewModel(true);
    commentRepository = CommentRepository();
  }

  @override
  void doGetComments(int idPost) {

    this.postDetailPageViewModel.loading = true;

    this.postDetailPageViewModel.FuturelistComment=commentRepository.fetchComments("/comments/getByPost/",[idPost]).then((value) {

      this.postDetailPageViewModel.listComment = value;
      this.postDetailPageViewModel.loading = false;
      this.postDetailPageViewModel.successfullyInserted = false;
      this.iCommentPageTab.doUpdateCommentPageTab(this.postDetailPageViewModel);

    });

    this.iCommentPageTab.doUpdateCommentPageTab(this.postDetailPageViewModel);
  }

  @override
  void doAddComment(Comment comment) {

    commentRepository.addComment("/comments/add/", comment).then((value) {
    this.postDetailPageViewModel.successfullyInserted = true;
    this.iPostDetailView.doUpdatePostDetailPage(this.postDetailPageViewModel);

    });

  }



}