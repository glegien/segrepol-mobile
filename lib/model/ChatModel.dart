class ChatModel{
  String chatId;
  String itemName;
  String itemDescription;

  ChatModel(this.chatId, this.itemName, this.itemDescription);

  static List<ChatModel> fromJson(Map<String, dynamic> json) {
    List<ChatModel> result = List.empty(growable:true);
    for (var el in json['result']) {
      result.add(ChatModel(el['chatId'], el['itemName'], el['itemDescription']));
    }
    return result;
  }
}