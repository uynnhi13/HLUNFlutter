import 'dart:convert';

class ProductModel {
  final int? id;
  final String name;
  final String desc;
  final String imgURL;
  final int price;
  final int categoryID;
  final String categoryName;

  ProductModel({
    this.id,
    required this.name,
    required this.desc,
    required this.imgURL,
    required this.price,
    required this.categoryID,
    required this.categoryName,
  });

  // Convert a Breed into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'imgURL':imgURL,
      'price':price,
      'categoryID':categoryID,
      'categoryName':categoryName,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      desc: map['description'] ?? '',
      imgURL: map['imageURL']??'',
      price: map['price']?.toInt() ??0,
      categoryID: map['categoryID']?.toInt()??0,
      categoryName: map['categoryName']??'',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));

  // Implement toString to make it easier to see information about
  // each breed when using the print statement.
  @override
  String toString() => 
  'Product(id: $id, name: $name, desc: $desc, imgURL: $imgURL, price: $price, categoryID: $categoryID, categoryName: $categoryName)';
}
