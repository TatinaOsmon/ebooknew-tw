import 'package:ebooknew/pages/bottom_navigation.dart';
import 'package:ebooknew/pages/sign_up.dart';
import 'package:ebooknew/utils/util.dart';
import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:ebooknew/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({Key? key, }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LoginViewModel loginViewModel = Get.put(LoginViewModel());
  ViewModel viewModel = Get.put(ViewModel());

  final formKey = GlobalKey<FormState>();





  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Obx(() => loginViewModel.loading.value == true
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * .07),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ///Image
            Image.asset('assets/login.png'),
            SizedBox(height: height * .04),

            ///Login Form
            Form(
                key: formKey,
                child: Column(
                  children: [

                    ///Account Number
                    TextFormField(
                      controller: emailController,
                      autofillHints: const [AutofillHints.email],

                      decoration: InputDecoration(
                          label: const Text('帳號'),
                          filled: true,
                          // fillColor: Colors.,

                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(width * .03)
                          )

                      ),
                      validator: (value){
                        if(emailController.text.isEmpty){
                          return '请输入帐号';
                        }
                      },
                    ),
                    SizedBox(height: height * .02),

                    ///Password
                    TextFormField(
                      controller: passwordController,
                      obscureText: loginViewModel.obSecurePassword.value,
                      decoration: InputDecoration(
                          label: const Text('密碼'),
                          filled: true,
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(width * .03)
                          ),
                          suffixIcon: IconButton(onPressed: (){
                            loginViewModel.visibilityPassword();
                          }, icon: loginViewModel.obSecurePassword.value == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))


                      ),
                      validator: (value){
                        if(passwordController.text.isEmpty){
                          return '请输入密码';
                        }
                      },
                    )
                  ],
                )),
            SizedBox(height: height * .02),

            ///Login Button
            GestureDetector(
              onTap: (){
                if(formKey.currentState!.validate()){
                  Map data = {
                    "account": emailController.text.toString(),
                    "password": passwordController.text.toString(),
                  };

                  loginViewModel.loginApi(data).then((value){

                    if(value['success'] == true){

                      viewModel.userId.value = value['userId'];
                      viewModel.jwtToken.value = value['jwtToken'];
                      viewModel.refreshToken.value = value['refreshToken'];

                      loginViewModel.loading.value = false;
                      Utils().toast('Login Successfully');
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavigation()), (route) => false);
                    }

                    else{
                      loginViewModel.loading.value = false;
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('用户名或密码无效'),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 2),
                              dismissDirection: DismissDirection.up));
                    }

                  }).onError((error, stackTrace) {

                    loginViewModel.loading.value = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(error.toString()),
                            backgroundColor: Colors.red,
                            duration: const Duration(seconds: 2),
                            dismissDirection: DismissDirection.up));
                  });
                }
              },
              child: Container(
                height: height * .07,
                width: double.infinity,

                decoration: BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.circular(width * .04)
                ),
                child: Center(child: Text('登入', style: TextStyle(color: Colors.white, fontSize: width * .07))),

              ),
            ),
            SizedBox(height: height * .02),

            ///SignUp
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUp()));
            }, child: Text('註冊新帳號', style: TextStyle(color: Colors.purple, fontSize: width * .06, decoration: TextDecoration.underline)))

          ],
        ),
      )
      ),
    );
  }
}
