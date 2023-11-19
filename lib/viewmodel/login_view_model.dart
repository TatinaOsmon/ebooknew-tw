import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginViewModel extends GetxController {
  RxBool obSecurePassword = true.obs;
  RxBool loading = false.obs;

  ///For Password
  Future visibilityPassword() async {
    obSecurePassword.value = !obSecurePassword.value;
  }

  Future loginApi(dynamic data) async {
    loading.value = true;
    var response = await http.post(
        Uri.parse('https://ebookapi.jizoji.org//appUser/login'),
        body: jsonEncode(data));

    if (response.statusCode == 200) {
      return jsonDecode(response.body.toString());
    } else {
      return throw Exception('SomeThing Went Wrong');
    }
  }
}
