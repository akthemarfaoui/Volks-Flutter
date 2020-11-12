import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Message.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/MessagingViewModel.dart';
import 'package:volks_demo/Presenter/MessagingPresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:volks_demo/Views/ConversationPage.dart';

class IMessagingView {
  void UpdateMessagingPage(MessagingViewModel messagingViewModel) {}
}

class MessagingPage extends StatefulWidget {
  User connectedUser;
  final MessagingPresenter messagingPresenter = MessagingPresenter();
  MessagingPage({this.connectedUser});
  @override
  MessagePageState createState() => MessagePageState();
}

class MessagePageState extends State<MessagingPage> implements IMessagingView {
  List<Message> messageList = [];


  @override
  void UpdateMessagingPage(MessagingViewModel messagingViewModel) {
    setState(() {
      this.messageList =
          messagingViewModel.list_of_last_messages_for_each_conversation;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.messagingPresenter.iMessagingView = this;
    widget.messagingPresenter.doGetChats(widget.connectedUser.username);

  }

@override
  void didUpdateWidget(MessagingPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.messagingPresenter.iMessagingView = this;

}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Chats',
          style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
        ),
        elevation: 0.0,

      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 500.0,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 5.0, bottom: 5.0),
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      decoration: BoxDecoration(
                          color: MyColors.bgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0))),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0)),
                        child: ListView.builder(
                          itemCount: this.messageList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final chat = this.messageList[index];
                            return GestureDetector(
                              onTap: () {

                                String otherUsername ="";

                                if(chat.sender == this.widget.connectedUser.username)
                                  {

                                    otherUsername = chat.receiver;

                                  }else{

                                    otherUsername = chat.sender;

                                }

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ConversationPage(connectedUser: this.widget.connectedUser,otherUsername: otherUsername),
                                  ),
                                );

                              },
                              child: Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30.0),
                                      topRight: Radius.circular(30.0),

                                  ),

                                ),

                                child: Container(

                                  margin: EdgeInsets.only(
                                      top: 5.0, bottom: 5.0, right: 5.0),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  decoration: BoxDecoration(
                                    //color: chat.unread ? Color(0xFFe4f1fe) : Colors.white,
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      )),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            radius: 25.0,
                                            backgroundImage: this
                                                .widget
                                                .connectedUser
                                                .username ==
                                                chat.sender
                                                ? getProfileImage(chat.receiver)
                                                .image
                                                : getProfileImage(chat.sender)
                                                .image,
                                          ),
                                          SizedBox(width: 10.0),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                this
                                                    .widget
                                                    .connectedUser
                                                    .username ==
                                                    chat.sender ? chat.receiver : chat.sender,
                                                style: TextStyle(
                                                    fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(height: 5.0),
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.45,
                                                child: Text(
                                                  chat.message,
                                                  style: TextStyle(
                                                      color: Colors.blueGrey,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                      FontWeight.w600),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[

                                          /*chat.unread ?
                          Container(
                              width: 40.0,
                              height: 20.0,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'New',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 9.5,
                                    fontWeight: FontWeight.bold
                                ),
                              )
                          ) : SizedBox.shrink()*/
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
