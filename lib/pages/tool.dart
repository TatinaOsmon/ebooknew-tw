import 'package:ebooknew/models/ToolResponse.dart';
import 'package:ebooknew/viewmodel/tool-view-model.dart';
import 'package:flutter/material.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({Key? key, }) : super(key: key);

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    ToolViewModel toolViewModel = ToolViewModel();

    return Scaffold(
      ///App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('書籍分類',
            style: TextStyle(color: Colors.white, fontSize: width * .07))),
      body: FutureBuilder<ToolResponse>(

          future: toolViewModel.getData(),
          builder: (context, snapshot){

              ///While fetching Data From Api
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
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
            else if(snapshot.data!.toolCategory!.isEmpty){
              return Center(child: Text('对不起！\n没有该类别的书', style: TextStyle(fontSize: width * .08), textAlign: TextAlign.center));
            }

            ///If Api Have Data
            else{
              return ListView.builder(
                  itemCount: snapshot.data!.toolCategory!.length,
                  itemBuilder: (context, index){
                    var data = snapshot.data!.toolCategory![index];

                    return Padding(
                      padding: EdgeInsets.only(left: width * .01),

                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          ///Image
                          Container(
                            // height: height * .05,
                            width: width * .39,
                            margin: EdgeInsets.symmetric(vertical: height * .01),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(width * .03),
                              child: FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: data.pic.toString(), fit: BoxFit.fill),
                            ),
                          ),

                          ///Title, price, description etc
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start  ,

                            children: [

                              ///Title
                              Text(data.title.toString(), style: TextStyle(fontSize: width * .06),),

                              ///Price
                              Text(data.price.toString(), style: TextStyle(color: const Color(0xff542EEC), fontSize: width * .06)),

                              ///Content
                              SizedBox(
                                  width: width * .55,
                                  child: Text(data.content.toString(), style: TextStyle(fontSize: width * .04), maxLines: 3)),

                              ///Add To Cart Burtton
                              Padding(padding: EdgeInsets.only(left: width * .25),
                                child: ElevatedButton(
                                  onPressed: () {
                                  },

                                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff542EEC)),
                                  child: const Text(
                                      '加入購物車'),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            }
            
          }),
    );
  }
}
