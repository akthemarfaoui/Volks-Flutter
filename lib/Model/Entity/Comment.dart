


class Comment
{

  int id;
  int post;
  String username;
  String comment;
  Comment({this.id,this.username,this.post,this.comment});
  Comment.forAdding({this.username,this.post,this.comment});

  Map toJson() => {

    'id': id,
    'post': post,
    'username': username,
    'comment': comment,

  };

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(

      id: json['id'] as dynamic,
      username: json['username'] as dynamic,
      post: json['post'] as dynamic,
      comment: json['comment'] as dynamic,

    );
  }
}