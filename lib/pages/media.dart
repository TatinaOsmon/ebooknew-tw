import 'package:ebooknew/pages/mp3.dart';
import 'package:ebooknew/pages/mp4.dart';
import 'package:flutter/material.dart';

class MediaScreen extends StatefulWidget {
  const MediaScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MediaScreen> createState() => _MediaScreenState();
}

class _MediaScreenState extends State<MediaScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('媒體櫃',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),
      ),
      body: Column(
        children: [
          SizedBox(height: height * .02),

          ///Mp3 Container
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Mp3Screen()));
            },
            child: Container(
              height: height * .35,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: width * .02),

              decoration: BoxDecoration(
                  color: const Color(0xff36BBCD),
                  borderRadius: BorderRadius.circular(width * .03)),

              ///Mp3 Image & Text
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/mp3.png', width: width * .75),
                  Text(
                    'mp3',
                    style: TextStyle(color: Colors.white, fontSize: width * .1),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: height * .02),

          ///Mp4 Container
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Mp4Screen()));
            },
            child: Container(
              height: height * .30,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: width * .02),
              decoration: BoxDecoration(
                  color: const Color(0xffD92222),
                  borderRadius: BorderRadius.circular(width * .03)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/video.png', width: width * .6),
                  Text('mp4',
                      style:
                          TextStyle(color: Colors.white, fontSize: width * .1))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

///where is remainng part?