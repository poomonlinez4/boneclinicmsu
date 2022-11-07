// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class BuyerBuyCourseModel {
  final String date;
  final String time;
  final String name;
  final String surname;
  final String phone;
  final String name_course;
  BuyerBuyCourseModel({
    required this.date,
    required this.time,
    required this.name,
    required this.surname,
    required this.phone,
    required this.name_course,
  });

  BuyerBuyCourseModel copyWith({
    String? date,
    String? time,
    String? name,
    String? surname,
    String? phone,
    String? name_course,
  }) {
    return BuyerBuyCourseModel(
      date: date ?? this.date,
      time: time ?? this.time,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: phone ?? this.phone,
      name_course: name_course ?? this.name_course,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'date': date,
      'time': time,
      'name': name,
      'surname': surname,
      'phone': phone,
      'name_course': name_course,
    };
  }

  factory BuyerBuyCourseModel.fromMap(Map<String, dynamic> map) {
    return BuyerBuyCourseModel(
      date: map['date'] as String,
      time: map['time'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      phone: map['phone'] as String,
      name_course: map['name_course'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyerBuyCourseModel.fromJson(String source) =>
      BuyerBuyCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyerBuyCourseModel(date: $date, time: $time, name: $name, surname: $surname, phone: $phone, name_course: $name_course)';
  }

  @override
  bool operator ==(covariant BuyerBuyCourseModel other) {
    if (identical(this, other)) return true;

    return other.date == date &&
        other.time == time &&
        other.name == name &&
        other.surname == surname &&
        other.phone == phone &&
        other.name_course == name_course;
  }

  @override
  int get hashCode {
    return date.hashCode ^
        time.hashCode ^
        name.hashCode ^
        surname.hashCode ^
        phone.hashCode ^
        name_course.hashCode;
  }
}
