import 'package:ebooknew/pages/login.dart';
import 'package:ebooknew/utils/util.dart';
import 'package:ebooknew/viewmodel/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key, }) : super(key: key);

  @override
  State<SignUp> createState() => _LoginState();
}

class _LoginState extends State<SignUp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  SignUpViewModel signUpViewModel = Get.put(SignUpViewModel());

  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();

  
  Future pickDate()async{
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2050)).then((value) {
          setState(() {
            selectedDate = value!;
          });
    });
  }


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * .07),

        child: Obx(() =>signUpViewModel.loading.value == true
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: height * .06),

                ///Register New account Text
                Text('註冊新帳號', style: TextStyle(fontSize: width * .08, fontWeight: FontWeight.bold)),
                SizedBox(height: height * .02),

                ///Let's create new account
                Text('让我们开始填写下面的表格。', style: TextStyle(fontSize: width * .05)),
                SizedBox(height: height * .04),

                ///Sign_Up Form
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
                          obscureText: signUpViewModel.obSecurePassword.value,
                          decoration: InputDecoration(
                              label: const Text('密碼'),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(width * .03)
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                signUpViewModel.visibilityPassword();
                              }, icon: signUpViewModel.obSecurePassword.value == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))


                          ),
                          validator: (value){
                            if(passwordController.text.isEmpty){
                              return '请输入密码';
                            }
                          },
                        ),
                        SizedBox(height: height * .02),

                        ///Confirm Password
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: signUpViewModel.obSecureConfirmPassword.value,
                          decoration: InputDecoration(
                              label: const Text('確認密碼'),
                              filled: true,
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(width * .03)
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                signUpViewModel.visibilityConfirmPassword();
                              }, icon: signUpViewModel.obSecureConfirmPassword.value == true ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility))


                          ),
                          validator: (value){
                            if(confirmPasswordController.text.isEmpty){
                              return '请重新输入密码';
                            }
                            else if(confirmPasswordController.text != passwordController.text){
                              return '密码不匹配';
                            }
                          },
                        ),
                        SizedBox(height: height * .02),

                        ///Name
                        TextFormField(
                          controller: nameController,
                          autofillHints: const [AutofillHints.email],

                          decoration: InputDecoration(
                              label: const Text('暱稱'),
                              filled: true,
                              // fillColor: Colors.,

                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(width * .03)
                              )

                          ),
                          validator: (value){
                            if(nameController.text.isEmpty){
                              return '请输入你的名字';
                            }
                          },
                        ),
                        SizedBox(height: height * .02),

                        ///BirthDay

                        Container(
                          height: height * .08,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(width * .04)
                          ),

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [


                              ///selected Date
                              Text(DateFormat('dd MMM yyy').format(selectedDate), style: TextStyle(fontSize: width * .045),),
                              SizedBox(width: width * .2),

                              ///Select Date Button
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                                onPressed: () => pickDate(),
                                child: const Text('選擇日期'),)

                            ],
                          ),
                        ),
                        SizedBox(height: height * .02),

                        ///Address
                        TextFormField(
                          controller: addressController,
                          autofillHints: const [AutofillHints.email],

                          decoration: InputDecoration(
                              label: const Text('地址'),
                              filled: true,
                              // fillColor: Colors.,

                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(width * .03)
                              )

                          ),
                          validator: (value){
                            if(addressController.text.isEmpty){
                              return '请输入您当前的地址';
                            }
                          },
                        ),
                      ],
                    )),
                SizedBox(height: height * .02),

                ///Login Button
                GestureDetector(
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      Map data = {
                        'account': emailController.text.toString(),
                        'password': passwordController.text.toString(),
                        'username': nameController.text.toString(),
                        'birthday': DateFormat('dd/MM/yyy').format(selectedDate),
                        'address': emailController.text.toString(),
                      };

                      signUpViewModel.signUpApi(data).then((value){

                        signUpViewModel.loading.value = false;
                        Utils().toast('Successfully Registered');
                        Navigator.pop(context);

                      }).onError((error, stackTrace){

                        signUpViewModel.loading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(error.toString()),
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 1),
                                dismissDirection: DismissDirection.down));
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
                    child: Center(child: Text('註冊', style: TextStyle(color: Colors.white, fontSize: width * .07))),

                  ),
                ),
                SizedBox(height: height * .04),

                ///Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('已經擁有帳號?', style: TextStyle(color: Colors.black, fontSize: width * .04)),
                    GestureDetector(

                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Login())),
                        child: Text('登入', style: TextStyle(color: Colors.purple, fontSize: width * .04, decoration: TextDecoration.underline)))
                  ],
                )

              ],
            )

        )),
      ),
    );
  }
}
