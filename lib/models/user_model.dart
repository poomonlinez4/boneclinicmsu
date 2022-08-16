// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String members_id;
  final String user;
  final String password;
  final String name;
  final String surname;
  final String sex;
  final String address;
  final String phone;
  final String email;
  final String pic_members;
  final String role_id;
  UserModel({
    required this.members_id,
    required this.user,
    required this.password,
    required this.name,
    required this.surname,
    required this.sex,
    required this.address,
    required this.phone,
    required this.email,
    required this.pic_members,
    required this.role_id,
  });

  UserModel copyWith({
    String? members_id,
    String? user,
    String? password,
    String? name,
    String? surname,
    String? sex,
    String? address,
    String? phone,
    String? email,
    String? pic_members,
    String? role_id,
  }) {
    return UserModel(
      members_id: members_id ?? this.members_id,
      user: user ?? this.user,
      password: password ?? this.password,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      sex: sex ?? this.sex,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      pic_members: pic_members ?? this.pic_members,
      role_id: role_id ?? this.role_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'members_id': members_id,
      'user': user,
      'password': password,
      'name': name,
      'surname': surname,
      'sex': sex,
      'address': address,
      'phone': phone,
      'email': email,
      'pic_members': pic_members,
      'role_id': role_id,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      members_id: map['members_id'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      sex: map['sex'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      pic_members: map['pic_members'] as String,
      role_id: map['role_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(members_id: $members_id, user: $user, password: $password, name: $name, surname: $surname, sex: $sex, address: $address, phone: $phone, email: $email, pic_members: $pic_members, role_id: $role_id)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.members_id == members_id &&
        other.user == user &&
        other.password == password &&
        other.name == name &&
        other.surname == surname &&
        other.sex == sex &&
        other.address == address &&
        other.phone == phone &&
        other.email == email &&
        other.pic_members == pic_members &&
        other.role_id == role_id;
  }

  @override
  int get hashCode {
    return members_id.hashCode ^
        user.hashCode ^
        password.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        sex.hashCode ^
        address.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        pic_members.hashCode ^
        role_id.hashCode;
  }
}
