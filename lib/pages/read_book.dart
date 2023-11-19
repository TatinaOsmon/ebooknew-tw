import 'package:ebooknew/pages/pdf_view.dart';
import 'package:flutter/material.dart';

class ReadBook extends StatefulWidget {
  final String image;
  final String text;
  final String content;
  final int productId;

  const ReadBook({Key? key,
    required this.image,
    required this.text,
    required this.content,
    required this.productId,

  }) : super(key: key);

  @override
  State<ReadBook> createState() => _ReadBookState();
}

class _ReadBookState extends State<ReadBook> {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      ///App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('書籍',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),

      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * .02),

          widget.image.isNotEmpty
          ///if There is an Image
              ? Container(
                width: double.infinity,
                height: height * .38,
                margin: EdgeInsets.symmetric(horizontal: width * .08),
  
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(width * .03),
                    child: FadeInImage.assetNetwork(placeholder: 'assets/placeholder.png', image: widget.image.toString(), fit: BoxFit.cover)))

          ///If No Image of coming
              : Container(
                  width: double.infinity,
                  height: height * .38,
                  margin: EdgeInsets.symmetric(horizontal: width * .08),

                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(width * .03),
                      child: Image.asset('assets/no_cover.png', fit: BoxFit.cover,))),
          SizedBox(height: height * .03),

          ///Title
          Center(child: Text(widget.text, style: TextStyle(fontSize: width * .1))),
          SizedBox(height: height * .03),

          ///Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .02),
            child: widget.content.isNotEmpty
                ? Text(widget.content, style: TextStyle(fontSize: width * .06), maxLines: 5)
                : Text('让我们开始阅读..', style: TextStyle(fontSize: width * .08),)
          ),
          SizedBox(height: height * .03),

          ///Read Book button
          Padding(
            padding: EdgeInsets.only(left: width * .63),
            child: ElevatedButton(

              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PdfView(productId: widget.productId)));
              },

              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff542EEC)),
              child: const Text(
                  '開始閱讀書籍'),
            ),
          ),
        ],
      ),
    );
  }
}
