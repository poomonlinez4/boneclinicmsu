class Chatmodel {
  String? chatId;
  String? membersId;
  String? membersUser;
  String? membersPic;
  String? membersPhone;

  Chatmodel(
      {this.chatId,
      this.membersId,
      this.membersUser,
      this.membersPic,
      this.membersPhone});

  Chatmodel.fromJson(Map<String, dynamic> json) {
    chatId = json['chat_id'];
    membersId = json['members_id'];
    membersUser = json['members_user'];
    membersPic = json['members_Pic'];
    membersPhone = json['members_phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chat_id'] = this.chatId;
    data['members_id'] = this.membersId;
    data['members_user'] = this.membersUser;
    data['members_Pic'] = this.membersPic;
    data['members_phone'] = this.membersPhone;
    return data;
  }
}
