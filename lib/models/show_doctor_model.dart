// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ShowDoctorModel {
  final String name;
  final String surname;
  final String sex;
  final String phone;
  final String pic_members;
  ShowDoctorModel({
    required this.name,
    required this.surname,
    required this.sex,
    required this.phone,
    required this.pic_members,
  });

  ShowDoctorModel copyWith({
    String? name,
    String? surname,
    String? sex,
    String? phone,
    String? pic_members,
  }) {
    return ShowDoctorModel(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      sex: sex ?? this.sex,
      phone: phone ?? this.phone,
      pic_members: pic_members ?? this.pic_members,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'surname': surname,
      'sex': sex,
      'phone': phone,
      'pic_members': pic_members,
    };
  }

  factory ShowDoctorModel.fromMap(Map<String, dynamic> map) {
    return ShowDoctorModel(
      name: map['name'] as String,
      surname: map['surname'] as String,
      sex: map['sex'] as String,
      phone: map['phone'] as String,
      pic_members: map['pic_members'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShowDoctorModel.fromJson(String source) =>
      ShowDoctorModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ShowDoctorModel(name: $name, surname: $surname, sex: $sex, phone: $phone, pic_members: $pic_members)';
  }

  @override
  bool operator ==(covariant ShowDoctorModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.surname == surname &&
        other.sex == sex &&
        other.phone == phone &&
        other.pic_members == pic_members;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        surname.hashCode ^
        sex.hashCode ^
        phone.hashCode ^
        pic_members.hashCode;
  }
}
