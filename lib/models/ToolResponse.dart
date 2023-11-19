import 'dart:convert';
/// toolCategory : [{"productId":1,"price":1000,"pic":"https://storage.googleapis.com/koyasan/toolCategory/b6c73587e0c94aa783f8cc0be86c65ec.png","id":1,"title":"木魚類","content":"Buddhism\nFine Carved Religious 3.5/4/5/6/7 inch Reddish Monk Wooden Fish Camphor Wood Melodious Voice Pray in Buddha Temple\nTool","tableName":"toolCategory"},{"productId":2,"price":2000,"pic":"https://storage.googleapis.com/koyasan/toolCategory/7fafee10257646db8f1f1792e3a66b29.png","id":2,"title":"法器分類2","content":"","tableName":"toolCategory"},{"productId":3,"price":3000,"pic":"https://storage.googleapis.com/koyasan/toolCategory/59e574b2777d4fa3a7ec42faf2bebd4c.png","id":3,"title":"法器分類3","content":"","tableName":"toolCategory"},{"productId":4,"price":4000,"pic":"https://storage.googleapis.com/koyasan/toolCategory/0bbe6df115b44e299fd529c86025f2c7.png","id":4,"title":"法器分類4","content":"","tableName":"toolCategory"}]

ToolResponse toolResponseFromJson(String str) => ToolResponse.fromJson(json.decode(str));
String toolResponseToJson(ToolResponse data) => json.encode(data.toJson());
class ToolResponse {
  ToolResponse({
      List<ToolCategory>? toolCategory,}){
    _toolCategory = toolCategory;
}

  ToolResponse.fromJson(dynamic json) {
    if (json['toolCategory'] != null) {
      _toolCategory = [];
      json['toolCategory'].forEach((v) {
        _toolCategory?.add(ToolCategory.fromJson(v));
      });
    }
  }
  List<ToolCategory>? _toolCategory;
ToolResponse copyWith({  List<ToolCategory>? toolCategory,
}) => ToolResponse(  toolCategory: toolCategory ?? _toolCategory,
);
  List<ToolCategory>? get toolCategory => _toolCategory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_toolCategory != null) {
      map['toolCategory'] = _toolCategory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// productId : 1
/// price : 1000
/// pic : "https://storage.googleapis.com/koyasan/toolCategory/b6c73587e0c94aa783f8cc0be86c65ec.png"
/// id : 1
/// title : "木魚類"
/// content : "Buddhism\nFine Carved Religious 3.5/4/5/6/7 inch Reddish Monk Wooden Fish Camphor Wood Melodious Voice Pray in Buddha Temple\nTool"
/// tableName : "toolCategory"

ToolCategory toolCategoryFromJson(String str) => ToolCategory.fromJson(json.decode(str));
String toolCategoryToJson(ToolCategory data) => json.encode(data.toJson());
class ToolCategory {
  ToolCategory({
      num? productId, 
      num? price, 
      String? pic, 
      num? id, 
      String? title, 
      String? content, 
      String? tableName,}){
    _productId = productId;
    _price = price;
    _pic = pic;
    _id = id;
    _title = title;
    _content = content;
    _tableName = tableName;
}

  ToolCategory.fromJson(dynamic json) {
    _productId = json['productId'];
    _price = json['price'];
    _pic = json['pic'];
    _id = json['id'];
    _title = json['title'];
    _content = json['content'];
    _tableName = json['tableName'];
  }
  num? _productId;
  num? _price;
  String? _pic;
  num? _id;
  String? _title;
  String? _content;
  String? _tableName;
ToolCategory copyWith({  num? productId,
  num? price,
  String? pic,
  num? id,
  String? title,
  String? content,
  String? tableName,
}) => ToolCategory(  productId: productId ?? _productId,
  price: price ?? _price,
  pic: pic ?? _pic,
  id: id ?? _id,
  title: title ?? _title,
  content: content ?? _content,
  tableName: tableName ?? _tableName,
);
  num? get productId => _productId;
  num? get price => _price;
  String? get pic => _pic;
  num? get id => _id;
  String? get title => _title;
  String? get content => _content;
  String? get tableName => _tableName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['price'] = _price;
    map['pic'] = _pic;
    map['id'] = _id;
    map['title'] = _title;
    map['content'] = _content;
    map['tableName'] = _tableName;
    return map;
  }

}