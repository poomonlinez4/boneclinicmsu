// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';

class WalletBuyerModel {
  final String id;
  final String id_buyer;
  final String total_money;
  WalletBuyerModel({
    required this.id,
    required this.id_buyer,
    required this.total_money,
  });

  WalletBuyerModel copyWith({
    String? id,
    String? id_buyer,
    String? total_money,
  }) {
    return WalletBuyerModel(
      id: id ?? this.id,
      id_buyer: id_buyer ?? this.id_buyer,
      total_money: total_money ?? this.total_money,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'id_buyer': id_buyer,
      'total_money': total_money,
    };
  }

  factory WalletBuyerModel.fromMap(Map<String, dynamic> map) {
    return WalletBuyerModel(
      id: map['id'] as String,
      id_buyer: map['id_buyer'] as String,
      total_money: map['total_money'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory WalletBuyerModel.fromJson(String source) =>
      WalletBuyerModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'WalletBuyerModel(id: $id, id_buyer: $id_buyer, total_money: $total_money)';

  @override
  bool operator ==(covariant WalletBuyerModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.id_buyer == id_buyer &&
        other.total_money == total_money;
  }

  @override
  int get hashCode => id.hashCode ^ id_buyer.hashCode ^ total_money.hashCode;
}
