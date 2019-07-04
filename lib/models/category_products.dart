import 'dart:convert';

List<CategoryProducts> categoryFromJson(String str) => new List<CategoryProducts>.from(json.decode(str).map((x)=>CategoryProducts.fromJson(x)));

String categoryToJson(List<CategoryProducts> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryProducts {
  int id;
  String category;

  CategoryProducts({
    this.id,
    this.category,
  });

  factory CategoryProducts.fromJson(Map<String, dynamic> json)=> new CategoryProducts(
    id: int.parse(json['id']),
    category: json['category'],
    );

    Map<String, dynamic> toJson() =>{
      ":id": id,
      ":category": category,
    };
}