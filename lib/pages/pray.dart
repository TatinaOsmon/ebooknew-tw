import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:ebooknew/utils/util.dart';
import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:ebooknew/viewmodel/pray-view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PrayScreen extends StatefulWidget {
  const PrayScreen({Key? key, }) : super(key: key);

  @override
  State<PrayScreen> createState() => _LoginState();
}

class _LoginState extends State<PrayScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController targetController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? option;

  PrayViewModel prayViewModel = Get.put(PrayViewModel());
  ViewModel viewModel = Get.put(ViewModel());

  final formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();


  Future pickDate()async{
    showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now()).then((value){
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
      ///App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('祈願',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),
      ),

      ///Body
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width * .07),

        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * .06),

                ///welcome text
                Text('Welcome to support', style: TextStyle(fontSize: width * .08, fontWeight: FontWeight.bold)),
                SizedBox(height: height * .02),

                ///prayer form text
                Text('祈願表單', style: TextStyle(fontSize: width * .05)),
                SizedBox(height: height * .04),

                ///Prayer Form
                Form(
                    key: formKey,
                    child: Column(
                      children: [

                        ///Name
                        TextFormField(
                          controller: nameController,
                          autofillHints: const [AutofillHints.email],

                          decoration: InputDecoration(
                              label: const Text('姓名'),
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
                            return null;
                          },
                        ),
                        SizedBox(height: height * .02),

                        ///Target Person Name
                        TextFormField(
                          controller: targetController,
                          decoration: InputDecoration(
                            label: const Text('祈願對象姓名'),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black),
                                borderRadius: BorderRadius.circular(width * .03)
                            ),


                          ),
                          validator: (value){
                            if(targetController.text.isEmpty){
                              return '请输入目标人的姓名';
                            }
                            return null;
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
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                                onPressed: () => pickDate(),
                                child: const Text('祈願對象生日'),)

                            ],
                          ),
                        ),
                        SizedBox(height: height * .02),

                        ///Address
                        TextFormField(
                          controller: addressController,
                          autofillHints: const [AutofillHints.email],

                          decoration: InputDecoration(
                              label: const Text('請填入祈願對象地址'),
                              filled: true,
                              // fillColor: Colors.,

                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.black),
                                  borderRadius: BorderRadius.circular(width * .03)
                              )

                          ),
                          validator: (value){
                            if(addressController.text.isEmpty){
                              return '请输入地址';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * .02),

                        ///DropDown Options
                        CustomDropdown(
                            closedBorder: Border.all(color: Colors.black),
                            hintText: '請選擇祈願類型',
                            onChanged: (value){
                              option = value.toString();
                            },
                            items: const [
                              "息災：滅除罪業、除去災害",
                              "增益：增進福德智慧",
                              "敬愛：得人親睦",
                              "調伏：化解怨敵災難、除滅煩惱",
                              "延命：身心安樂，無諸病苦、心願達成",
                            ]
                        )
                      ],
                    )),
                SizedBox(height: height * .03),

                ///Submit Button
                GestureDetector(
                  onTap: (){
                    if(option == null){
                      ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
                        content: Text('请从下拉列表中选择选项'),
                        backgroundColor: Colors.red,
                      ));
                    }

                    else if(formKey.currentState!.validate()){
                      Map data = {
                        "userId": viewModel.userId.value,
                        "name": nameController.text.toString(),
                        "target": targetController.text.toString(),
                        "birthday": DateFormat('dd/MM/yyy').format(selectedDate),
                        "address": addressController.toString(),
                        "options": option.toString(),
                      };
                      
                      prayViewModel.postPrayForm(data).then((value) {
                        
                        prayViewModel.loading.value = false;
                        Utils().toast('数据提交成功');
                        nameController.clear();
                        targetController.clear();
                        addressController.clear();

                      }).onError((error, stackTrace) {

                        prayViewModel.loading.value = false;
                        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                        content: Text(error.toString()),
                        backgroundColor: Colors.red,
                        ));

                      });
                    }

                  },
                  child: Container(
                    height: height * .07,
                    width: double.infinity,

                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(width * .08)
                    ),
                    child: Obx(() => Center(
                        child:prayViewModel.loading.value == true
                            ? const Center(child: CircularProgressIndicator())
                            : Row(
                          mainAxisAlignment: MainAxisAlignment.center ,
                          children: [
                            Icon(Icons.send, size: width * .073, color: Colors.white,),
                            SizedBox(width: width * .02),

                            Text('提交祈願表單', style: TextStyle(color: Colors.white, fontSize: width * .063)),
                          ],
                        ))),

                  ),
                ),


              ],
            )

        ),
      ),
    );
  }
}
