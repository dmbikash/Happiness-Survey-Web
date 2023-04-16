import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String? _fileName;
  String? _uploadStatus;
  var image;

  Future<void> _pickImage() async {
    image = await ImagePicker().pickImage(source: ImageSource.gallery);
    print("aaaaaaaaaaaaaa");
    print(image.name);
    print("bbbbbbbbbbb");
    if (Image != null) {
      setState(() {
        _fileName = image.name;
      });
    }
  }

  Future<void> _uploadImage() async {
    debugPrint("ii");
    if (_fileName == null) {
      setState(() {
        print("garbar");
        _uploadStatus = 'Please pick an image first.';
      });
      return;
    }
    debugPrint("ii");
    final url = Uri.parse('http://localhost:8000/image/upload');

    final request = http.MultipartRequest(
      'POST',
      url,
    );

    Uint8List data = await image.readAsBytes();
    List<int> list = data.cast();
    request.files
        .add(http.MultipartFile.fromBytes('file', list, filename: image.name));

    // Now we can make this call

    var response = await request.send();
    //We've made a post request...
    //Let's read response now
    response.stream.bytesToString().asStream().listen((event) {
      var parsedJson = json.decode(event);
      print(parsedJson);
      print(response.statusCode);
      //It's done...
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            if (_fileName != null) ...[
              SizedBox(height: 16),
              Text('Selected file: $_fileName'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text('Upload Image'),
              ),
            ],
            if (_uploadStatus != null) ...[
              SizedBox(height: 16),
              Text(_uploadStatus!),
            ],
          ],
        ),
      ),
    );
  }
}
