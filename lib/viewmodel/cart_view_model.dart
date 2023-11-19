import 'dart:convert';
import "package:ebooknew/models/CartResposne.dart";
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartViewModel extends GetxController {
  RxNum total = RxNum(0);

  Future<CartResposne> getCartData() async {
    var response = await http.get(
        Uri.parse(('https://ebookapi.jizoji.org//bookcart/findAll?userId=1')));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      var finalData = CartResposne.fromJson(data);
      total.value = 0;

      for (var i = 0; i < finalData.bookcart!.length; i++) {
        total.value += finalData.bookcart![i].price!;
      }

      return finalData;
    } else {
      return throw Exception('There is no Data');
    }
  }
}
