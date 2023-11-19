import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';

import 'package:ebooknew/viewmodel/common_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

// class PdfView extends StatefulWidget {
//   final int productId;

//   const PdfView({
//     Key? key,
//     required this.productId,
//   }) : super(key: key);

//   @override
//   State<PdfView> createState() => _PdfViewState();
// }

// class _PdfViewState extends State<PdfView> {
//   ViewModel viewModel = Get.put(ViewModel());
//   String? password;
//   Uint8List file = Uint8List(0);

//   ///Generate Password
//   Future generateMd5(String input) async {
//     var bytes = utf8.encode(input);
//     var md5Hash = md5.convert(bytes).toString();
//     setState(() {
//       password = md5Hash;
//     });

//     return password;
//   }

//   ///last time we just giving link and passeord and it download and open pdf itself. but now it's not possible because
//   ///we need give some parameters like mp3 and mp4. so here too we make post request and get encrypted file.
//   ///Get Pdf File
//   Future pdfFile() async {
//     var response = await http.post(
//         Uri.parse('https://ebookapi.jizoji.org//book/downloadBook'),
//         body: jsonEncode({
//           "userId": viewModel.userId.value,
//           "jwtToken": viewModel.jwtToken.value,
//           "refreshToken": viewModel.refreshToken.value,
//           "productId": widget.productId
//         }));

//     setState(() {
//       ///here we get pdf file bytes
//       file = response.bodyBytes;
//     });
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     generateMd5('${viewModel.userId.value + widget.productId}jfaojeoihaog3892');
//     pdfFile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(

//         ///last time we was using SfPdfViewer.network because we was downloading pdf direct from server through api
//         ///but now we already have pdf in upper function that's why we use SfPdfViewer.memory. it will do same work too
//         ///// what about page? you impliment your logic of shared preferances. Okay
//         /// evening I will try again learn from you hehehehe. sure in evening , yeeeeeeees, now send me file, and i wanna send other thing too heheh
//         body: SfPdfViewer.memory(
//       file,
//       password: password,
//       canShowPageLoadingIndicator: true,
//     ));
//   }
// }

class PdfView extends StatefulWidget {
  final int productId;

  PdfView({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  ViewModel viewModel = Get.put(ViewModel());
  late PdfViewerController _pdfViewerController;
  String? password;
  Uint8List file = Uint8List(0);

  // Define the GlobalKey
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();
    generateMd5('${viewModel.userId.value + widget.productId}jfaojeoihaog3892')
        .then((_) {
      pdfFile().then((_) {
        // Ensure the widget is still mounted before calling setState
        if (mounted) {
          WidgetsBinding.instance
              .addPostFrameCallback((_) => getAndJumpToPage());
        }
      });
    });
  }

  @override
  void dispose() {
    _pdfViewerController.dispose();
    super.dispose();
  }

  Future<void> generateMd5(String input) async {
    var bytes = utf8.encode(input);
    var md5Hash = md5.convert(bytes).toString();
    setState(() {
      password = md5Hash;
    });
  }

  Future<void> pdfFile() async {
    try {
      var response = await http.post(
          Uri.parse('https://ebookapi.jizoji.org//book/downloadBook'),
          body: jsonEncode({
            "userId": viewModel.userId.value,
            "jwtToken": viewModel.jwtToken.value,
            "refreshToken": viewModel.refreshToken.value,
            "productId": widget.productId
          }));

      if (response.statusCode == 200) {
        setState(() {
          file = response.bodyBytes;
        });
      } else {
        // Handle error or show an error message
      }
    } catch (e) {
      // Handle network/error exceptions
    }
  }

  void _savePageNumber(int pageNumber) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('currentPageNum${widget.productId}', pageNumber);
    print("Page number saved: $pageNumber");
  }

  Future<void> getAndJumpToPage() async {
    final prefs = await SharedPreferences.getInstance();
    int? savedPage = prefs.getInt('currentPageNum${widget.productId}');
    print("Retrieved saved page: $savedPage");
    if (savedPage != null) {
      // Add delay if needed to ensure the document is loaded
      await Future.delayed(Duration(milliseconds: 500));
      _pdfViewerController.jumpToPage(savedPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: file.isNotEmpty
          ? Directionality(
              textDirection: TextDirection.rtl, // Set to RTL
              child: SfPdfViewer.memory(
                file,
                key: _pdfViewerKey, // Assign the GlobalKey here
                password: password,
                canShowPageLoadingIndicator: true,
                controller: _pdfViewerController,
                scrollDirection: PdfScrollDirection.horizontal,

                onDocumentLoaded: (details) {
                  _pdfViewerController.addListener(() {
                    int currentPage = _pdfViewerController.pageNumber;
                    _savePageNumber(currentPage);
                  });
                },
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}
