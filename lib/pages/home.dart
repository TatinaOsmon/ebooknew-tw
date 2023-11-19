import 'package:ebooknew/models/all_book_response.dart';
import 'package:ebooknew/pages/book_version.dart';
import 'package:ebooknew/pages/cart_screen.dart';
import 'package:ebooknew/viewmodel/all_book_view_model.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    BookViewModel bookViewModel = BookViewModel();
    return Scaffold(

        ///App Bar
        appBar: AppBar(
          backgroundColor: const Color(0xff542EEC),
          centerTitle: true,
          title: Text('書籍分類',
              style: TextStyle(color: Colors.white, fontSize: width * .07)),
          actions: [
            IconButton(
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
              },
              icon: Icon(Icons.shopping_cart_outlined,
                  size: height * .042, color: Colors.white),
            ),
          ],
        ),

        ///Body
        body: FutureBuilder<AllBookResponse>(
          future: bookViewModel.getData(),
          builder: (BuildContext context, snapshot) {
            ///we will show loading until we get data from Api
            if (snapshot.connectionState == ConnectionState.waiting) {
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

            ///If APi Have No Data
            else if(snapshot.data!.bookCategory == null){
              return Center(child: Text('对不起！\n没有该类别的书', style: TextStyle(fontSize: width * .08), textAlign: TextAlign.center));
            }

            else {
              return GridView.builder(

                  ///We Will show item That snapshot have so we will give it's length

                  itemCount: snapshot.data!.bookCategory!.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(

                      ///Cross Axis Count Mean How many items will show in row
                      crossAxisCount: 2,

                      ///Main Axis Spacing Mean how much space between two rows
                      mainAxisSpacing: 9 / 1,

                      ///Cross Axis mean space between items in row
                      crossAxisSpacing: 2 / 3,
                      childAspectRatio: 2.9 / 5),
                  itemBuilder: (context, index) {

                    var data = snapshot.data!.bookCategory![index];

                    return Container(
                      width: width * .1,
                      margin: EdgeInsets.only(
                          left: width * .02,
                          right: width * .02,
                          top: height * .01
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(width * .03)
                      ),
                      
                      child: Column(
                        children: [

                          ///Picture
                          Container(
                              height: height * .2,
                              width: width * .4,
                              padding: EdgeInsets.only(top: height * .01),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(width * .03),
                                child: data.pic == null
                                  ? Image.asset('assets/no_cover.png')
                                  : FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: data.pic.toString(), fit: BoxFit.cover),
                              )),
                          SizedBox(height: height * .01),

                          ///Price
                          Text(data.price.toString(), style: TextStyle(fontSize: width * .06, fontWeight: FontWeight.bold)),
                          SizedBox(height: height * .01),

                          ///Content
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: width * .02),
                            child: data.content == null
                              ? Text(data.title.toString())
                              : Text(data.content.toString(), maxLines: 2),
                          ),
                          SizedBox(height: height * .01),

                          ///Add To Cart
                          Padding(padding: EdgeInsets.only(left: width * .12),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => BookVersion(id: data.id.toString(),)));
                              },

                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff542EEC)),
                              child: const Text(
                                '加入購物車'),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            }
          },
        ));
  }
}
