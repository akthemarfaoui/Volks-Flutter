import 'package:volks_demo/Model/Repository/MessageRepositoy.dart';
import 'package:volks_demo/Model/ViewModel/MessagingViewModel.dart';
import 'package:volks_demo/Views/ConversationPage.dart';
import 'package:volks_demo/Views/MessagingPage.dart';

class IMessagingPresenter
{

  void doGetChats(String ConnectedUsername){}


  void doGetMessages(String Me,String Other){}



  void doSendMessage()
  {

  }
  void doReceiveMessage()
  {

  }
}


class MessagingPresenter implements IMessagingPresenter
{

  MessageRepository mr;
  MessagingViewModel messagingViewModel;
  IMessagingView iMessagingView;
  IConversationView iConversationView;

  MessagingPresenter()
  {
    mr=MessageRepository();
    messagingViewModel = MessagingViewModel();
  }

  @override
  void doGetChats(String ConnectedUsername) {

    mr.fetchChats("/message/getAll/",[ConnectedUsername]).then((value){


      this.messagingViewModel.list_of_last_messages_for_each_conversation = value;
      this.iMessagingView.UpdateMessagingPage(messagingViewModel);


    });

  }

  @override
  void doGetMessages(String Me,String Other) {

    mr.fetchChats("/message/getAll/",[Me,Other]).then((value){


      this.messagingViewModel.list_of_conversation = value;
      this.iConversationView.UpdateConversationPage(messagingViewModel);

    });

  }



  @override
  void doReceiveMessage() {
    // TODO: implement doReceiveMessage
  }

  @override
  void doSendMessage() {
    // TODO: implement doSendMessage
  }






}