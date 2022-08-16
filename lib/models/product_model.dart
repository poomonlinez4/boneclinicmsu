// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String product_id;
  final String name_product;
  final String detail_product;
  final String price_product;
  final String pic_product;
  ProductModel({
    required this.product_id,
    required this.name_product,
    required this.detail_product,
    required this.price_product,
    required this.pic_product,
  });

  ProductModel copyWith({
    String? product_id,
    String? name_product,
    String? detail_product,
    String? price_product,
    String? pic_product,
  }) {
    return ProductModel(
      product_id: product_id ?? this.product_id,
      name_product: name_product ?? this.name_product,
      detail_product: detail_product ?? this.detail_product,
      price_product: price_product ?? this.price_product,
      pic_product: pic_product ?? this.pic_product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product_id': product_id,
      'name_product': name_product,
      'detail_product': detail_product,
      'price_product': price_product,
      'pic_product': pic_product,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      product_id: map['product_id'] as String,
      name_product: map['name_product'] as String,
      detail_product: map['detail_product'] as String,
      price_product: map['price_product'] as String,
      pic_product: map['pic_product'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(product_id: $product_id, name_product: $name_product, detail_product: $detail_product, price_product: $price_product, pic_product: $pic_product)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.product_id == product_id &&
        other.name_product == name_product &&
        other.detail_product == detail_product &&
        other.price_product == price_product &&
        other.pic_product == pic_product;
  }

  @override
  int get hashCode {
    return product_id.hashCode ^
        name_product.hashCode ^
        detail_product.hashCode ^
        price_product.hashCode ^
        pic_product.hashCode;
  }
}
