import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:volks_demo/Model/Entity/Message.dart';
import 'package:volks_demo/Model/Entity/User.dart';
import 'package:volks_demo/Model/ViewModel/MessagingViewModel.dart';
import 'package:volks_demo/Presenter/MessagingPresenter.dart';
import 'package:volks_demo/Utils/HttpConfig.dart';
import 'package:volks_demo/Utils/MyColors.dart';
import 'package:web_socket_channel/io.dart';



class IConversationView{

  void UpdateConversationPage(MessagingViewModel messagingViewModel){}

}


class ConversationPage extends StatefulWidget {
  final User connectedUser;
  final String otherUsername;


  final MessagingPresenter messagingPresenter = MessagingPresenter();
  ConversationPage({this.connectedUser,this.otherUsername});

  @override
  ConversationState createState() => ConversationState();
}

class ConversationState extends State<ConversationPage> implements IConversationView {
  TextEditingController messageToSend = TextEditingController();

  List<Message> list_conversation = [];
  final IOWebSocketChannel channel = IOWebSocketChannel.connect(WEB_SOCKET_URL);
  final _scrollController = ScrollController();
  bool send = false;


  @override
  UpdateConversationPage(MessagingViewModel messagingViewModel)
  {
    setState(() {
      this.list_conversation = messagingViewModel.list_of_conversation;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.messagingPresenter.iConversationView = this;
    widget.messagingPresenter.doGetMessages(widget.connectedUser.username,this.widget.otherUsername);

    channel.stream.listen((onData) {

      Message msg = Message();
      msg.sender = jsonDecode(onData)["sender"];
      msg.receiver = jsonDecode(onData)["receiver"];
      msg.message = jsonDecode(onData)["message"];
      msg.send_in = jsonDecode(onData)["send_in"];
      this.messageToSend.text= "";
      print(jsonDecode(onData)["send_in"]);
      setState(() {

        this.list_conversation.add(msg);

      });

      setState(() {

        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);

      });

    });

  }


  @override
  void didUpdateWidget(ConversationPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.messagingPresenter.iConversationView = this;

  }

  _buildMessage(Message message, bool isMe){
    final Container msg = Container(
      width: MediaQuery.of(context).size.width * 0.75,
      margin: isMe
          ? EdgeInsets.only(top: 7.0, bottom: 8.0, left: 80.0)
          : EdgeInsets.only(top:8.0, bottom: 8.0),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      decoration: isMe ? BoxDecoration(
          color: MyColors.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              bottomLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0)
          )
      ) : BoxDecoration(
          color: MyColors.commentColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0),
              topRight: Radius.circular(15.0),
              bottomRight: Radius.circular(15.0)
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            getFormatedDateFromSQlForTexting(message.send_in) ?? "",
            style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 13.0,
                fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 8.0,)
          ,       Text(
              message.message,
            style: TextStyle(
                fontSize: 17.0, color: Colors.black87, fontWeight: FontWeight.normal),

          ),
        ],
      ),
    );
    if (isMe){
      return msg;
    }
    return Row(
      children: <Widget>[

        msg,

      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.photo),
            iconSize: 25.0,
            color: MyColors.primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: this.messageToSend,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  hintText: 'Send a message..'
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: MyColors.primaryColor,
            onPressed: () {
              if(this.messageToSend.text.isNotEmpty)
                {
                  _sendMessage(this.messageToSend.text);
                  this.messageToSend.text="";
                }

            },
          ),
        ],
      ),
    );
  }

  _buildDiscussion()
  {
    return
    Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0)
                    )
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0)
                  ),
                  child: ListView.builder(
                    controller: _scrollController,
                      padding: EdgeInsets.only(top: 14.0),
                      itemCount: this.list_conversation.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Message message = this.list_conversation[index];
                        final bool isMe = message.sender == this.widget.connectedUser.username;
                        return _buildMessage(message, isMe);
                      }
                  ),
                )
            ),
          ),
          _buildMessageComposer(),
        ],
      );
  }


  _sendMessage(String msg)
  {

    Message msgToSend =new Message.toSend(widget.connectedUser.username,widget.otherUsername,msg);
    channel.sink.add(jsonEncode(msgToSend));
    print(jsonEncode(msgToSend));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.primaryColor,
      appBar: AppBar(
        title: Text(
          widget.otherUsername,
          style: TextStyle(

              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],

      backgroundColor: MyColors.primaryColor,
      ),
      body:  _buildDiscussion()


      /*
      StreamBuilder(

        stream: channel.stream,
        builder: (context,snapshot){
          if (snapshot.hasError)
            return Text('Error: ${snapshot.error}');

          switch (snapshot.connectionState)
          {
            case ConnectionState.none: {
              return Text('No connection'); break;
            }
            case ConnectionState.waiting:
              {
                return _buildDiscussion();
                break;
              }
            case ConnectionState.active:
              {



              break;
              }
            case ConnectionState.done:
              {
                return Text('${snapshot.data} (closed)');
                break;
              }
          }

          print(snapshot.connectionState);
          if(snapshot.hasData)
          {

            Message msg = Message();
            msg.sender = jsonDecode(snapshot.data)["sender"];
            msg.receiver = jsonDecode(snapshot.data)["receiver"];
            msg.message = jsonDecode(snapshot.data)["message"];
            this.messageToSend.text= "";
            this.list_conversation.add(msg);
            print(msg);
            return _buildDiscussion();
          }


        } ,


      )*/




    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }


}