import 'package:flutter/material.dart';
import 'HttpConfig.dart';


class UserAvatar extends StatefulWidget {
  final String username;

  final double height,width;
  const UserAvatar({
    this.username,
    this.height,this.width,
    Key key,
  }) : super(key: key);

  @override
  UserAvatarState createState() {
    return new UserAvatarState();
  }
}

class UserAvatarState extends State<UserAvatar>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new UserAvatarWithAnimation(widget: widget);
  }

  @override
  bool get wantKeepAlive => true;
}

class UserAvatarWithAnimation extends StatefulWidget {

  const UserAvatarWithAnimation({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final UserAvatar widget;

  @override
  UserAvatarWithAnimationState createState() {
    return new UserAvatarWithAnimationState();
  }
}

class UserAvatarWithAnimationState extends State<UserAvatarWithAnimation>
    with SingleTickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;
  bool isLoaded = false;
  NetworkImage _image;


  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _image = getPostProfileImage(widget.widget.username);
   /* _image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, call) {
              isLoaded = true;
              print('Networkimage is fully loaded and saved');

        },
      ),
    );
*/
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    final CurvedAnimation curvedAnimation = CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: FractionalTranslation(
        child: Material(
          type: MaterialType.circle,
          color: Colors.white,
          elevation: 10.0,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.transparent,
                  border: Border.all(width: 1.0, color: Colors.transparent)),
              height: widget.widget.height,
              width: widget.widget.width,
              child: /*isLoaded ?*/ CircleAvatar(

                backgroundImage: getPostProfileImage(widget.widget.username),

              ) /*:  new Center(
                child: CircularProgressIndicator(
                  valueColor:
                  new AlwaysStoppedAnimation<Color>(MyColors.PostColor),
                ),
              )*/  ),
        ),
        translation: Offset(-0.5, 0.82),
      ),
    );
  }
}