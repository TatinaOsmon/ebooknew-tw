import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PrayViewModel extends GetxController {
  RxBool loading = false.obs;

  Future postPrayForm(dynamic data) async {
    loading.value = true;

    var response = await http.post(
        Uri.parse('https://ebookapi.jizoji.org//pray/submitForm'),
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      return throw Exception('Please Try Again Later!!!');
    }
  }
}
