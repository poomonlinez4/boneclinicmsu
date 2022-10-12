class Chatmodel {
  String? chatId;
  String? membersId;
  String? name;
  String? surname;
  String? user;
  String? picMembers;
  String? roleName;

  Chatmodel(
      {this.chatId,
      this.membersId,
      this.name,
      this.surname,
      this.user,
      this.picMembers,
      this.roleName});

  Chatmodel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    membersId = json['members_id'];
    name = json['name'];
    surname = json['surname'];
    user = json['user'];
    picMembers = json['pic_members'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['members_id'] = this.membersId;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['user'] = this.user;
    data['pic_members'] = this.picMembers;
    data['role_name'] = this.roleName;
    return data;
  }
}
