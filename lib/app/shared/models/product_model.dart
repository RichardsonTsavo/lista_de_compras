import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  String? id;
  String? name;
  String? image;
  double? price;
  int? amount;
  bool? isPurchased;
  ProductModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.amount,
    this.isPurchased,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'amount': amount,
      'isPurchased': isPurchased,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      image: map['image'] != null ? map['image'] as String : null,
      price: map['price'] != null ? map['price'] as double : null,
      amount: map['amount'] != null ? map['amount'] as int : null,
      isPurchased:
          map['isPurchased'] != null ? map['isPurchased'] as bool : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ProductModel copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? amount,
    bool? isPurchased,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      amount: amount ?? this.amount,
      isPurchased: isPurchased ?? this.isPurchased,
    );
  }
}
