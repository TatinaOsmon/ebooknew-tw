import 'dart:convert';
/// Bookcart : [{"price":100,"index":87,"id":27,"pic":"","title":"server1-1"},{"price":200,"index":88,"id":28,"pic":"","title":"server1-2"}]

CartResposne cartResposneFromJson(String str) => CartResposne.fromJson(json.decode(str));
String cartResposneToJson(CartResposne data) => json.encode(data.toJson());
class CartResposne {
  CartResposne({
      List<Bookcart>? bookcart,}){
    _bookcart = bookcart;
}

  CartResposne.fromJson(dynamic json) {
    if (json['Bookcart'] != null) {
      _bookcart = [];
      json['Bookcart'].forEach((v) {
        _bookcart?.add(Bookcart.fromJson(v));
      });
    }
  }
  List<Bookcart>? _bookcart;
CartResposne copyWith({  List<Bookcart>? bookcart,
}) => CartResposne(  bookcart: bookcart ?? _bookcart,
);
  List<Bookcart>? get bookcart => _bookcart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_bookcart != null) {
      map['Bookcart'] = _bookcart?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// price : 100
/// index : 87
/// id : 27
/// pic : ""
/// title : "server1-1"

Bookcart bookcartFromJson(String str) => Bookcart.fromJson(json.decode(str));
String bookcartToJson(Bookcart data) => json.encode(data.toJson());
class Bookcart {
  Bookcart({
      num? price, 
      num? index, 
      num? id, 
      String? pic, 
      String? title,}){
    _price = price;
    _index = index;
    _id = id;
    _pic = pic;
    _title = title;
}

  Bookcart.fromJson(dynamic json) {
    _price = json['price'];
    _index = json['index'];
    _id = json['id'];
    _pic = json['pic'];
    _title = json['title'];
  }
  num? _price;
  num? _index;
  num? _id;
  String? _pic;
  String? _title;
Bookcart copyWith({  num? price,
  num? index,
  num? id,
  String? pic,
  String? title,
}) => Bookcart(  price: price ?? _price,
  index: index ?? _index,
  id: id ?? _id,
  pic: pic ?? _pic,
  title: title ?? _title,
);
  num? get price => _price;
  num? get index => _index;
  num? get id => _id;
  String? get pic => _pic;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['price'] = _price;
    map['index'] = _index;
    map['id'] = _id;
    map['pic'] = _pic;
    map['title'] = _title;
    return map;
  }

}