import 'dart:convert';
/// books : [{"productId":27,"purchased":false,"createTime":"Mon Oct 02 06:06:25 UTC\n2023","price":100,"pic":"","title":"server1-1","categoryId":8,"content":"","tableName":"book"},{"productId":28,"purchased":false,"createTime":"Mon\nOct 02 06:06:46 UTC\n2023","price":200,"pic":"","title":"server1-2","categoryId":8,"content":"佛教常見的法器有法輪、念珠、袈裟、缽、八吉祥、摩尼寶、法鼓、木魚、佛足石、轉經筒、金剛等，多是對佛、法、僧三寶有表徵和莊嚴意義。\n道教\n道教常見的法器有八卦鏡、木魚、羅盤、天珠、鞭、桃木劍、符籙、香等。這些法器因為被認為有驅邪避凶的作用，亦被一般大眾用於護身，或放在家門前做鎮煞之用","tableName":"book"},{"productId":30,"purchased":false,"createTime":"Wed\nOct 25 01:32:31 UTC 2023","price":0,"pic":"","title":"TestFor","categoryId":8,"content":"簡介123","tableName":"book"}]

BookVersionResponse bookVersionResponseFromJson(String str) => BookVersionResponse.fromJson(json.decode(str));
String bookVersionResponseToJson(BookVersionResponse data) => json.encode(data.toJson());
class BookVersionResponse {
  BookVersionResponse({
      List<Books>? books,}){
    _books = books;
}

  BookVersionResponse.fromJson(dynamic json) {
    if (json['books'] != null) {
      _books = [];
      json['books'].forEach((v) {
        _books?.add(Books.fromJson(v));
      });
    }
  }
  List<Books>? _books;
BookVersionResponse copyWith({  List<Books>? books,
}) => BookVersionResponse(  books: books ?? _books,
);
  List<Books>? get books => _books;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_books != null) {
      map['books'] = _books?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// productId : 27
/// purchased : false
/// createTime : "Mon Oct 02 06:06:25 UTC\n2023"
/// price : 100
/// pic : ""
/// title : "server1-1"
/// categoryId : 8
/// content : ""
/// tableName : "book"

Books booksFromJson(String str) => Books.fromJson(json.decode(str));
String booksToJson(Books data) => json.encode(data.toJson());
class Books {
  Books({
      num? productId, 
      bool? purchased, 
      String? createTime, 
      num? price, 
      String? pic, 
      String? title, 
      num? categoryId, 
      String? content, 
      String? tableName,}){
    _productId = productId;
    _purchased = purchased;
    _createTime = createTime;
    _price = price;
    _pic = pic;
    _title = title;
    _categoryId = categoryId;
    _content = content;
    _tableName = tableName;
}

  Books.fromJson(dynamic json) {
    _productId = json['productId'];
    _purchased = json['purchased'];
    _createTime = json['createTime'];
    _price = json['price'];
    _pic = json['pic'];
    _title = json['title'];
    _categoryId = json['categoryId'];
    _content = json['content'];
    _tableName = json['tableName'];
  }
  num? _productId;
  bool? _purchased;
  String? _createTime;
  num? _price;
  String? _pic;
  String? _title;
  num? _categoryId;
  String? _content;
  String? _tableName;
Books copyWith({  num? productId,
  bool? purchased,
  String? createTime,
  num? price,
  String? pic,
  String? title,
  num? categoryId,
  String? content,
  String? tableName,
}) => Books(  productId: productId ?? _productId,
  purchased: purchased ?? _purchased,
  createTime: createTime ?? _createTime,
  price: price ?? _price,
  pic: pic ?? _pic,
  title: title ?? _title,
  categoryId: categoryId ?? _categoryId,
  content: content ?? _content,
  tableName: tableName ?? _tableName,
);
  num? get productId => _productId;
  bool? get purchased => _purchased;
  String? get createTime => _createTime;
  num? get price => _price;
  String? get pic => _pic;
  String? get title => _title;
  num? get categoryId => _categoryId;
  String? get content => _content;
  String? get tableName => _tableName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['purchased'] = _purchased;
    map['createTime'] = _createTime;
    map['price'] = _price;
    map['pic'] = _pic;
    map['title'] = _title;
    map['categoryId'] = _categoryId;
    map['content'] = _content;
    map['tableName'] = _tableName;
    return map;
  }

}