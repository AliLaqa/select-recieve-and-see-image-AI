

import 'dart:convert';
// import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:select_and_see_image/showimage.dart';

class LoadingScreen extends StatefulWidget {

  Uint8List? photo;

  LoadingScreen({required this.photo});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  String prompt = "portrait of handsome man, 1face, 1man";

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Future<void> _loadData(String base64Image) async {
  Future<void> _loadData() async {
    print('part 1');

    String base64image = base64.encode(widget.photo!);


    Uint8List faceswap = await sendRequest(prompt, base64image);

    // await Future.delayed(Duration(seconds: 2));

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NextScreen(
            imageData: faceswap,
          )),
    );
    // });
  }

  @override
  Widget build(BuildContext context) {
    // List<Map<String, dynamic>> images = widget.images;

    return Scaffold(
      backgroundColor:
      const Color.fromARGB(255, 2, 2, 17), // navy background color

      body: Center(
        child: LoadingAnimationWidget.beat(
          color: Colors.white,
          size: 200,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _rewardedAd?.dispose();
    super.dispose();
  }


  Future<Uint8List> sendRequest(String prompt, String base64Image) async {

    print(base64Image);
    final String url = 'http://103.111.39.182:8800/faceswap';

    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        'prompt': prompt,
        'source_image': base64Image,
      }),
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, convert the byte data to Uint8List.
      final bytes = response.bodyBytes;
      final uint8List = Uint8List.fromList(bytes);
      return uint8List;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load response');
    }
  }

}
