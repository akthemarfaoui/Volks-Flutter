class Post {
  int id;
  String username;
  String posted_in;
  String description;
  String group_name;
  String position;

  Post({
    this.id,
    this.username,
    this.posted_in,
    this.description,
    this.group_name,
    this.position,
  });

  Post.AnotherCtor(String Username, String Description) {
    this.username = Username;
    // this.posted_in = PostedIn.toIso8601String();
    this.description = Description;
  }

  Map toJson() => {
        'username': username,
        'posted_in': posted_in,
        'description': description,
        'group_name': group_name,
        'position': position,
      };

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as dynamic,
      username: json['username'] as dynamic,
      posted_in: json['posted_in'] as dynamic,
      description: json['description'] as dynamic,
      group_name: json['group_name'] as dynamic,
      position: json['position'] as dynamic,
    );
  }
}
