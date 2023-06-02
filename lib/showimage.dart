import 'dart:typed_data';
import 'package:flutter/material.dart';

class NextScreen extends StatelessWidget {
  final Uint8List imageData;

  const NextScreen({Key? key, required this.imageData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Next Screen'),
      ),
      body: Center(
        child: Image.memory(
          imageData,
          fit: BoxFit.contain,
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
