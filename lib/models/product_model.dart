// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(
    json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
  int id;
  String name;
  String description;
  String barcode;
  String image;
  int stock;
  int price;
  int categoryId;
  int userId;
  int statusId;
  DateTime createdAt;
  DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.barcode,
    required this.image,
    required this.stock,
    required this.price,
    required this.categoryId,
    required this.userId,
    required this.statusId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        barcode: json["barcode"],
        image: json["image"],
        stock: json["stock"],
        price: json["price"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        statusId: json["status_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "barcode": barcode,
        "image": image,
        "stock": stock,
        "price": price,
        "category_id": categoryId,
        "user_id": userId,
        "status_id": statusId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
