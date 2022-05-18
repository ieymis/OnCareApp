class Message{
  final int id;
  final String sender_id,reciever_id, message;
  final DateTime date;
  final bool sent;

  Message(this.id, this.sender_id, this.reciever_id, this.message, this.date, this.sent);

  static Message fromJson(json) => Message(
      json['id'],
      json['sender_id'].toString(),
      json['reciever_id'],
      json['message'],
      DateTime.parse(json['date']),
    true
  );

}