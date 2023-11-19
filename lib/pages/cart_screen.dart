import 'package:ebooknew/models/CartResposne.dart';
import 'package:ebooknew/viewmodel/cart_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key, }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    CartViewModel cartViewModel = Get.put(CartViewModel());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('書籍購物車',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          FutureBuilder<CartResposne>(
              future: cartViewModel.getCartData(),
              builder: (context, snapshot){

                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator());
                }

                else if(snapshot.hasError){
                  return Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('SomeThing Went Wrong!', style: TextStyle(fontSize: width * .06, color: Colors.red),),
                        SizedBox(width: width * .02),

                        Icon(Icons.wifi_off_outlined, size: width * .08,)
                      ],
                    ),
                  );
                }

                else if(snapshot.data!.bookcart!.isEmpty){
                  return Center(child: Text('对不起！\n没有该类别的书', style: TextStyle(fontSize: width * .08), textAlign: TextAlign.center));

                }

                else{

                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.bookcart!.length,
                      itemBuilder: (context, index){

                        var data = snapshot.data!.bookcart![index];

                        return Card(
                          elevation: 5,
                          margin: EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .01),

                          child: ListTile(
                            title: Text(data.title.toString(), style: TextStyle(fontSize: width * .06)),
                            subtitle: Text('${'\$'}${data.price.toString()}', style: TextStyle(fontSize: width * .05,color: Color(0xff542EEC))),
                            leading: Icon(Icons.menu_book_outlined, size: width * .09),
                            trailing: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black)
                              ),
                              child: Icon(Icons.delete, size: width * .08),
                            ),
                          ),
                        );
                      });
                }
              }),
          SizedBox(height: height * .02),

          Padding(
            padding: EdgeInsets.only(right: width * .04),
            child: Column(
              children: [
                Obx(() => Text('${'總價\$'}${cartViewModel.total.value.toString()}', style: TextStyle(fontSize: width * .06, color: const Color(0xff542EEC)))),
                SizedBox(height: height * .01),

                Container(
                  height: height * .06,
                  width: width * .35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(width * .05)
                  ),

                  child: Center(child: Text('送出訂單', style: TextStyle(color: Colors.white, fontSize: width * .05))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
