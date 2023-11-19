import 'package:ebooknew/models/BookVersionResponse.dart';
import 'package:ebooknew/pages/read_book.dart';
import 'package:ebooknew/utils/util.dart';
import 'package:ebooknew/viewmodel/add_to_cart_view_model.dart';
import 'package:ebooknew/viewmodel/book_version_view_model.dart';
import 'package:flutter/material.dart';

class BookVersion extends StatefulWidget {
  final String id;

  const BookVersion({Key? key,
    required this.id

  }) : super(key: key);

  @override
  State<BookVersion> createState() => _BookVersionState();
}

class _BookVersionState extends State<BookVersion> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    BookVersionViewModel bookVersionViewModel = BookVersionViewModel();
    AddTOCartViewModel addToCart = AddTOCartViewModel();

    return Scaffold(
      ///App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('加入購物車',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart_outlined,
                size: height * .042, color: Colors.white),
          ),
        ],
      ),

      body: FutureBuilder<BookVersionResponse>(

        future: bookVersionViewModel.apiData(widget.id),
        builder: (context, snapshot){

          ///While fetching Data From Api
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }

          ///If internet connection gone or any other error Occurred
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
          else if(snapshot.data!.books == null){
            return Center(child: Text('对不起！\n没有该类别的书', style: TextStyle(fontSize: width * .08), textAlign: TextAlign.center));
          }

          ///If Api Have Data
          else{
            return ListView.builder(
                itemCount: snapshot.data!.books!.length,
                itemBuilder: (context, index){

                  var data = snapshot.data!.books![index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(horizontal: width * .03, vertical: height * .01),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(vertical: height * .01, horizontal: width * .02),
                      ///When Click On Book
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            ReadBook(
                              image: data.pic.toString(),
                              text: data.title.toString(),
                              content: data.content.toString(),
                              productId: int.parse(data.productId.toString()),
                            )));
                      },

                      ///Name & Price & Add to Cart Button
                      title: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data.title.toString(), style: TextStyle(fontSize: width * .065)),
                              Text(data.price.toString(), style: TextStyle(color: Colors.deepPurpleAccent, fontWeight: FontWeight.bold, fontSize: width * .055)),
                              SizedBox(height: height * .01)
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width * .43),
                            child: ElevatedButton(
                              onPressed: () {

                                addToCart.addBook(data.productId.toString()).then((value){
                                  setState(() {
                                    Utils().toast('Book Added Successfully');
                                  });

                                }).onError((error, stackTrace){
                                 setState(() {
                                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                     content: Text('Please Try Again later!'),
                                     backgroundColor: Colors.red,
                                     duration: Duration(seconds: 2),
                                     dismissDirection: DismissDirection.up,
                                   ));
                                 });
                                });
                              },

                              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff542EEC)),
                              child: const Text(
                                  '加入購物車'),
                            ),
                          )
                        ],
                      ),

                      ///Icon
                      leading: Icon(Icons.menu_book_outlined, size: height * .06),

                      subtitle:data.content!.isEmpty ? const Text('简介 123') : Text(data.content.toString(), maxLines: 3),

                    ),
                  );
                });
          }
        }
      ),
    );
  }
}
