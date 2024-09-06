// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'product_model.dart';

class ShoppingListModel {
  String? id;
  String? name;
  List<ProductModel>? products;
  ShoppingListModel({
    this.id,
    this.name,
    this.products,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'products': products?.map((x) => x.toMap()).toList(),
    };
  }

  factory ShoppingListModel.fromMap(Map<String, dynamic> map) {
    return ShoppingListModel(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      products: map['products'] != null
          ? List<ProductModel>.from(
              (map['products'] as List<dynamic>).map<ProductModel?>(
                (x) => ProductModel.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ShoppingListModel.fromJson(String source) =>
      ShoppingListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ShoppingListModel copyWith({
    String? id,
    String? name,
    List<ProductModel>? products,
  }) {
    return ShoppingListModel(
      id: id ?? this.id,
      name: name ?? this.name,
      products: products ?? this.products,
    );
  }
}
