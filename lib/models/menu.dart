import 'dart:convert';

List<Menu> menuFromJson(String str) => new List<Menu>.from(json.decode(str).map((x) => Menu.fromJson(x)));

String menuToJson(List<Menu> data) => json.encode(new List<dynamic>.from(data.map((x) => x.toJson())));

class Menu {
    String id;
    String name;
    String portion;
    String image;
    num price;
    int category;
    String description;

    Menu({
        this.id,
        this.name,
        this.portion,
        this.image,
        this.price,
        this.category,
        this.description,
    });

    factory Menu.fromJson(Map<String, dynamic> json) => new Menu(
        id: json["id"],
        name: json["name"],
        portion: json["portion"],
        image: json["image"],
        price: num.parse(json["price"]),
        category: int.parse(json["category"]),
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "portion": portion,
        "image": image,
        "price": price,
        "category": category,
        "description": description,
    };
}