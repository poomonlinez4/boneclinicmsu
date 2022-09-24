// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CourseModel {
  final String course_id;
  final String name_course;
  final String detail_course;
  final String pic_course;
  final String price;
  final String amount;
  CourseModel({
    required this.course_id,
    required this.name_course,
    required this.detail_course,
    required this.pic_course,
    required this.price,
    required this.amount,
  });
  //final String id_admid;

  CourseModel copyWith({
    String? course_id,
    String? name_course,
    String? detail_course,
    String? pic_course,
    String? price,
    String? amount,
  }) {
    return CourseModel(
      course_id: course_id ?? this.course_id,
      name_course: name_course ?? this.name_course,
      detail_course: detail_course ?? this.detail_course,
      pic_course: pic_course ?? this.pic_course,
      price: price ?? this.price,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'course_id': course_id,
      'name_course': name_course,
      'detail_course': detail_course,
      'pic_course': pic_course,
      'price': price,
      'amount': amount,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      course_id: map['course_id'] as String,
      name_course: map['name_course'] as String,
      detail_course: map['detail_course'] as String,
      pic_course: map['pic_course'] as String,
      price: map['price'] as String,
      amount: map['amount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CourseModel(course_id: $course_id, name_course: $name_course, detail_course: $detail_course, pic_course: $pic_course, price: $price, amount: $amount)';
  }

  @override
  bool operator ==(covariant CourseModel other) {
    if (identical(this, other)) return true;

    return other.course_id == course_id &&
        other.name_course == name_course &&
        other.detail_course == detail_course &&
        other.pic_course == pic_course &&
        other.price == price &&
        other.amount == amount;
  }

  @override
  int get hashCode {
    return course_id.hashCode ^
        name_course.hashCode ^
        detail_course.hashCode ^
        pic_course.hashCode ^
        price.hashCode ^
        amount.hashCode;
  }
}
