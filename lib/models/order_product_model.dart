// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderProductModel {
  final String id;
  final String total_price;
  final String date_time;
  final String status;
  final String address;
  OrderProductModel({
    required this.id,
    required this.total_price,
    required this.date_time,
    required this.status,
    required this.address,
  });

  OrderProductModel copyWith({
    String? id,
    String? total_price,
    String? date_time,
    String? status,
    String? address,
  }) {
    return OrderProductModel(
      id: id ?? this.id,
      total_price: total_price ?? this.total_price,
      date_time: date_time ?? this.date_time,
      status: status ?? this.status,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total_price': total_price,
      'date_time': date_time,
      'status': status,
      'address': address,
    };
  }

  factory OrderProductModel.fromMap(Map<String, dynamic> map) {
    return OrderProductModel(
      id: map['id'] as String,
      total_price: map['total_price'] as String,
      date_time: map['date_time'] as String,
      status: map['status'] as String,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductModel.fromJson(String source) =>
      OrderProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProductModel(id: $id, total_price: $total_price, date_time: $date_time, status: $status, address: $address)';
  }

  @override
  bool operator ==(covariant OrderProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.total_price == total_price &&
        other.date_time == date_time &&
        other.status == status &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        total_price.hashCode ^
        date_time.hashCode ^
        status.hashCode ^
        address.hashCode;
  }
}
