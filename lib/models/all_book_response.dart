
class AllBookResponse {
  List<BookCategory>? bookCategory;

  AllBookResponse({this.bookCategory});

  AllBookResponse.fromJson(Map<String, dynamic> json) {
    if(json["bookCategory"] is List) {
      bookCategory = json["bookCategory"] == null ? null : (json["bookCategory"] as List).map((e) => BookCategory.fromJson(e)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    if(bookCategory != null) {
      _data["bookCategory"] = bookCategory?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class BookCategory {
  int? productId;
  bool? purchased;
  int? price;
  String? pic;
  int? id;
  String? title;
  String? content;
  String? tableName;

  BookCategory({this.productId, this.purchased, this.price, this.pic, this.id, this.title, this.content, this.tableName});

  BookCategory.fromJson(Map<String, dynamic> json) {
    if(json["productId"] is int) {
      productId = json["productId"];
    }
    if(json["purchased"] is bool) {
      purchased = json["purchased"];
    }
    if(json["price"] is int) {
      price = json["price"];
    }
    if(json["pic"] is String) {
      pic = json["pic"];
    }
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["title"] is String) {
      title = json["title"];
    }
    if(json["content"] is String) {
      content = json["content"];
    }
    if(json["tableName"] is String) {
      tableName = json["tableName"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["productId"] = productId;
    _data["purchased"] = purchased;
    _data["price"] = price;
    _data["pic"] = pic;
    _data["id"] = id;
    _data["title"] = title;
    _data["content"] = content;
    _data["tableName"] = tableName;
    return _data;
  }
}