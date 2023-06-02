import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:select_and_see_image/load_image.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  Uint8List? imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Spacer(),
          ElevatedButton(
            onPressed: pickFile,
            child: Text(
              'Pick File',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (imageData != null)
            Image.memory(
              imageData!,
              fit: BoxFit.contain,
              width: 200,
              height: 200,
            ),
          Spacer(),
        ],
      ),
    );
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      setState(() {
        PlatformFile file = result.files.first;
        imageData = file.bytes;
      });

      // Navigate to the next screen and pass the image data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoadingScreen(photo: imageData!),
        ),
      );
    }
  }
}
