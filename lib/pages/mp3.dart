import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Mp3Screen extends StatefulWidget {
  const Mp3Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<Mp3Screen> createState() => _Mp3ScreenState();
}

class _Mp3ScreenState extends State<Mp3Screen> {
  ViewModel viewModel = Get.put(ViewModel());

  ///Variables For Password Generation
  final int productId = 10;
  final String tableName = 'mp3';

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
  } //first check it's mp4 file otherwise don't run it

//download and play audio out of project mean locally play that audio i wanrt seeta,i okay
  ///Zip File
  Future zipFile() async {
    ///here download zip file
    ///here and in mp4 just do that we make post "http.post" instead of 'http.get', next in post we add body
    ///because we want to give few things. just this little change we do in mp3 and mp4.

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
        print(file.content);

        ///Store Name in Name List & bytes in Files list
        setState(() {
          names.add(file.name);
          files.add(file.content);
        });
      }
    }
  }
  //open that mp3 file where is that

  ///Play Audio Function
  Future<void> playAudio(file) async {
    final audioPlayer = AudioPlayer();
    try {
      await audioPlayer.play(BytesSource(file));
    } catch (e) {
      //run it open terminal
      print('Error playing audio: $e');
    }

    ///Now Play the audio that we are giving down in GridView

    // await audioPlayer.play(BytesSource(file), mode: PlayerMode.mediaPlayer, volume: 80S);
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
          title: Text('mp3',
              style: TextStyle(color: Colors.white, fontSize: width * .07)),
        ),
        body: names.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Colors.black))
            : ListView.builder(
                padding: EdgeInsets.symmetric(
                    horizontal: width * .02, vertical: height * .01),
                itemCount: names.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: GestureDetector(
                      onTap: () {
                        playAudio(files[index]);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: height * .02, horizontal: width * .02),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ///Icon
                            Icon(Icons.multitrack_audio,
                                color: Colors.black, size: width * .13),
                            SizedBox(width: width * .02),

                            ///Text
                            Text('錄音檔 ${index + 1}',
                                style: TextStyle(fontSize: width * .08)),
                          ],
                        ),
                      ),
                    ),
                  );
                }));
  }
}
