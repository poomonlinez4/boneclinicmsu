// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class OrderProductDetailModel {
  final String name_product;
  final String amountProduct;
  final String price_product;
  final String total;
  final String pic_product;
  OrderProductDetailModel({
    required this.name_product,
    required this.amountProduct,
    required this.price_product,
    required this.total,
    required this.pic_product,
  });

  OrderProductDetailModel copyWith({
    String? name_product,
    String? amountProduct,
    String? price_product,
    String? total,
    String? pic_product,
  }) {
    return OrderProductDetailModel(
      name_product: name_product ?? this.name_product,
      amountProduct: amountProduct ?? this.amountProduct,
      price_product: price_product ?? this.price_product,
      total: total ?? this.total,
      pic_product: pic_product ?? this.pic_product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name_product': name_product,
      'amountProduct': amountProduct,
      'price_product': price_product,
      'total': total,
      'pic_product': pic_product,
    };
  }

  factory OrderProductDetailModel.fromMap(Map<String, dynamic> map) {
    return OrderProductDetailModel(
      name_product: map['name_product'] as String,
      amountProduct: map['amountProduct'] as String,
      price_product: map['price_product'] as String,
      total: map['total'] as String,
      pic_product: map['pic_product'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderProductDetailModel.fromJson(String source) =>
      OrderProductDetailModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderProductDetailModel(name_product: $name_product, amountProduct: $amountProduct, price_product: $price_product, total: $total, pic_product: $pic_product)';
  }

  @override
  bool operator ==(covariant OrderProductDetailModel other) {
    if (identical(this, other)) return true;

    return other.name_product == name_product &&
        other.amountProduct == amountProduct &&
        other.price_product == price_product &&
        other.total == total &&
        other.pic_product == pic_product;
  }

  @override
  int get hashCode {
    return name_product.hashCode ^
        amountProduct.hashCode ^
        price_product.hashCode ^
        total.hashCode ^
        pic_product.hashCode;
  }
}
