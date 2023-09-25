// ignore_for_file: prefer_collection_literals

class Products {
  String? category;
  String? description;
  dynamic id;
  String? image;
  dynamic price;
  Rating? rating;
  String? title;
  int? cartCount;

  Products({
    this.category,
    this.description,
    this.id,
    this.image,
    this.price,
    this.rating,
    this.title,
    this.cartCount = 1,
  });

  Products.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    description = json['description'];
    id = json['id'];
    image = json['image'];
    price = json['price'];
    cartCount = json['cartCount'] ?? 1;
    rating =
        json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['cartCount'] = cartCount;
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['title'] = title;
    return data;
  }
}

class Rating {
  dynamic count;
  dynamic rate;

  Rating({this.count, this.rate});

  Rating.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['count'] = count;
    data['rate'] = rate;
    return data;
  }
}
