import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as gl;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location/location.dart';

class UploadForm extends StatefulWidget {
  const UploadForm({super.key});

  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final TextEditingController _commentController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  String? _city;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    List<gl.Placemark> placemarks = await gl.placemarkFromCoordinates(
      locationData.latitude!,
      locationData.longitude!,
    );
    setState(() {
      _city = placemarks[0].locality;
    });
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> _uploadPost() async {
    if (_image == null || _commentController.text.isEmpty || _city == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all fields')),
      );
      return;
    }

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('traffic_images').child(fileName);

    UploadTask uploadTask = firebaseStorageRef.putFile(File(_image!.path));
    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('trafficUpdates').add({
      'image_url': downloadUrl,
      'comment': _commentController.text,
      'city': _city,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Post uploaded successfully')),
    );

    _commentController.clear();
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Traffic Update')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _image == null
                ? const Text('No image selected.')
                : Image.file(File(_image!.path)),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(labelText: 'Comment'),
            ),
            const SizedBox(height: 10),
            Text(_city != null ? 'City: $_city' : 'Fetching city...'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Pick Image'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _uploadPost,
              child: const Text('Upload Post'),
            ),
          ],
        ),
      ),
    );
  }
}
