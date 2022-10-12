// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class BuyCourseModel {
  String? buycourse_id;
  String? course_id;
  String? id_Buyer;
  String? date;
  String? time;
  String? quantity;
  BuyCourseModel({
    this.buycourse_id,
    this.course_id,
    this.id_Buyer,
    this.date,
    this.time,
    this.quantity,
  });

  BuyCourseModel copyWith({
    String? buycourse_id,
    String? course_id,
    String? id_Buyer,
    String? date,
    String? time,
    String? quantity,
  }) {
    return BuyCourseModel(
      buycourse_id: buycourse_id ?? this.buycourse_id,
      course_id: course_id ?? this.course_id,
      id_Buyer: id_Buyer ?? this.id_Buyer,
      date: date ?? this.date,
      time: time ?? this.time,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buycourse_id': buycourse_id,
      'course_id': course_id,
      'id_Buyer': id_Buyer,
      'date': date,
      'time': time,
      'quantity': quantity,
    };
  }

  factory BuyCourseModel.fromMap(Map<String, dynamic> map) {
    return BuyCourseModel(
      buycourse_id:
          map['buycourse_id'] != null ? map['buycourse_id'] as String : null,
      course_id: map['course_id'] != null ? map['course_id'] as String : null,
      id_Buyer: map['id_Buyer'] != null ? map['id_Buyer'] as String : null,
      date: map['date'] != null ? map['date'] as String : null,
      time: map['time'] != null ? map['time'] as String : null,
      quantity: map['quantity'] != null ? map['quantity'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory BuyCourseModel.fromJson(String source) =>
      BuyCourseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BuyCourseModel(buycourse_id: $buycourse_id, course_id: $course_id, id_Buyer: $id_Buyer, date: $date, time: $time, quantity: $quantity)';
  }

  @override
  bool operator ==(covariant BuyCourseModel other) {
    if (identical(this, other)) return true;

    return other.buycourse_id == buycourse_id &&
        other.course_id == course_id &&
        other.id_Buyer == id_Buyer &&
        other.date == date &&
        other.time == time &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return buycourse_id.hashCode ^
        course_id.hashCode ^
        id_Buyer.hashCode ^
        date.hashCode ^
        time.hashCode ^
        quantity.hashCode;
  }
}
