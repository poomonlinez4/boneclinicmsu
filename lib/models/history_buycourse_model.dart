// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

class HistoryBuycourseModel {
  // final String buycourse_id;
  final String name_course;
  final String price;
  final String date;
  final String time;
  final String quantity;
  final String pic_course;
  final String detail_course;
  HistoryBuycourseModel({
    required this.name_course,
    required this.price,
    required this.date,
    required this.time,
    required this.quantity,
    required this.pic_course,
    required this.detail_course,
  });

  HistoryBuycourseModel copyWith({
    String? name_course,
    String? price,
    String? date,
    String? time,
    String? quantity,
    String? pic_course,
    String? detail_course,
  }) {
    return HistoryBuycourseModel(
      name_course: name_course ?? this.name_course,
      price: price ?? this.price,
      date: date ?? this.date,
      time: time ?? this.time,
      quantity: quantity ?? this.quantity,
      pic_course: pic_course ?? this.pic_course,
      detail_course: detail_course ?? this.detail_course,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_course': name_course,
      'price': price,
      'date': date,
      'time': time,
      'quantity': quantity,
      'pic_course': pic_course,
      'detail_course': detail_course,
    };
  }

  factory HistoryBuycourseModel.fromMap(Map<String, dynamic> map) {
    return HistoryBuycourseModel(
      name_course: map['name_course'] as String,
      price: map['price'] as String,
      date: map['date'] as String,
      time: map['time'] as String,
      quantity: map['quantity'] as String,
      pic_course: map['pic_course'] as String,
      detail_course: map['detail_course'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory HistoryBuycourseModel.fromJson(String source) =>
      HistoryBuycourseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'HistoryBuycourseModel(name_course: $name_course, price: $price, date: $date, time: $time, quantity: $quantity, pic_course: $pic_course, detail_course: $detail_course)';
  }

  @override
  bool operator ==(covariant HistoryBuycourseModel other) {
    if (identical(this, other)) return true;

    return other.name_course == name_course &&
        other.price == price &&
        other.date == date &&
        other.time == time &&
        other.quantity == quantity &&
        other.pic_course == pic_course &&
        other.detail_course == detail_course;
  }

  @override
  int get hashCode {
    return name_course.hashCode ^
        price.hashCode ^
        date.hashCode ^
        time.hashCode ^
        quantity.hashCode ^
        pic_course.hashCode ^
        detail_course.hashCode;
  }
}
