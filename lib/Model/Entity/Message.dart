
class Message
{

  int id;
  String sender;
  String receiver;
  String message;
  String send_in;


  Message({this.id,this.sender,this.receiver,this.message,this.send_in});

  Message.toSend(String sender,String receiver,String message){
    this.sender  =sender;
    this.receiver = receiver;
    this.message =message;

  }


  Map toJson() => {
    'sender': sender,
    'receiver': receiver,
    'message': message,
    'send_in': send_in,

  };

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(

      id: json['id'] as dynamic,
      sender: json['sender'] as dynamic,
      receiver: json['receiver'] as dynamic,
      message: json['message'] as dynamic,
      send_in: json['send_in'] as dynamic,

    );
  }

  @override
  String toString() {

    return "id: "+this.id.toString()+ " sender: "+sender.toString()+" receiver: "+receiver.toString()+" message: "+message.toString();

  }


}


