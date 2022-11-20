class ConservationModel{
  String chatId;
  String senderId;
  String message;
  String timestamp;


  ConservationModel(this.chatId, this.senderId, this.message, this.timestamp);

  static List<ConservationModel> fromJson(Map<String, dynamic> json) {
    List<ConservationModel> result = List.empty(growable:true);
    for (var el in json['result']) {
      result.add(ConservationModel(el['chatId'], el['senderId'], el['message'], el['timestamp']));
    }
    return result;
  }
}