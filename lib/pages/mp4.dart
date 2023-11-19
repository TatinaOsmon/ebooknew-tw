import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

class Mp4Screen extends StatefulWidget {
  const Mp4Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Mp4Screen> createState() => _Mp4ScreenState();
}

class _Mp4ScreenState extends State<Mp4Screen> {
  late VideoPlayerController controller;
  ViewModel viewModel = Get.put(ViewModel());
  final int productId = 2;
  final String tableName = 'mp4';

  ///Password will Store in this variables
  String? password;

  ///File Name Will be in This List
  List names = [];

  ///Files bytes will be in this List
  List files = [];

  ///This is Function That i use to get password
  generateMd5(String input) {
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    setState(() {
      password = md5Hash;
    });

    return password;
  }

  ///download, decrypt & extract Zip file Here
  Future zipFile() async {
    ///Everything is same just change little have written in mp3 page visit it
    final response = await http.post(
        Uri.parse(
            'https://ebookapi.jizoji.org//compressEncryptFile/downloadFile'),
        body: jsonEncode({
          "userId": viewModel.userId.value,
          "jwtToken": viewModel.jwtToken.value,
          "refreshToken": viewModel.refreshToken.value,
          "productId": productId,
          "tableName": tableName,
        }));

    ///Get bytes
    var bytes = response.bodyBytes;

    ///decrypt And extract zip file here
    final archive = ZipDecoder().decodeBytes(bytes, password: password);

    ///Get All Files Names & bytes
    for (final file in archive) {
      if (file.isFile) {
        ///Store Name in Name List & bytes in Files list
        setState(() {
          names.add(file.name);
          files.add(file.content);
        });
      }
    }
  }
  //18 year old girl open local mp3 file and play it in mac,ou tsoikdae y big bro
  //that was not mp3 file see it by eyes 18 year old girl
  //downlolad and play mp3 file which one?

  ///Play Video function is this
  Future playVideo() async {
    ///use cache Manager because video Player didn't accept bytes. That's why we use cache manager
    final cacheManager = CacheManager(Config('mp4'));

    ///convert video bytes into file so that video player play video
    final video = await cacheManager.putFile('mp4', files[0]);

    ///here we give it video file and then initialize it too so that it start play video
    controller = VideoPlayerController.file(video)
      ..initialize().then((value) {
        setState(() {
          controller.play();
        });
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    generateMd5(
        '${viewModel.userId.value + productId}${tableName}ggsegjsihje1624724');
    zipFile();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff542EEC),
        centerTitle: true,
        title: Text('mp4',
            style: TextStyle(color: Colors.white, fontSize: width * .07)),
      ),
      body: names.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.black))
          : ListView.builder(
              padding: EdgeInsets.symmetric(
                  horizontal: width * .02, vertical: height * .01),
              itemCount: names.length,
              itemBuilder: (context, index) {
                ///Play Audio
                return Card(
                  elevation: 5,
                  child: GestureDetector(
                    onTap: () {
                      ///Play video by click here, & give file where we click
                      playVideo().then((value) {
                        ///As video play we use alert dialog to show video
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                ///from here can change video size like height & width
                                content: Container(
                                  width: 673.3,
                                  height: 358.4,
                                  child: AspectRatio(
                                    aspectRatio: controller.value.aspectRatio,
                                    child: VideoPlayer(controller),
                                  ),
                                ),
                              );
                            });
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: height * .02, horizontal: width * .02),
                      child: Row(
                        children: [
                          Icon(Icons.slow_motion_video_outlined,
                              color: Colors.black, size: width * .12),
                          SizedBox(width: width * .02),
                          Text('影片 ${index + 1}',
                              style: TextStyle(fontSize: width * .08)),
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
