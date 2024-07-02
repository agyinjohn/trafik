import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color(0xff18181A),
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
    ),
  );
}

Future<Uint8List?> pickImageFromGallery() async {
  FilePickerResult? pickedFile =
      await FilePicker.platform.pickFiles(type: FileType.image);
  if (pickedFile != null) {
    if (kIsWeb) {
      return pickedFile.files.single.bytes!;
    }
    return await File(pickedFile.files.single.path!).readAsBytes();
  }
  return null;
}

Future<String> uploadProfileToStorage(
    Uint8List profileImage, String uid) async {
  FirebaseStorage storage = FirebaseStorage.instance;

  Reference ref = storage.ref().child('profile-pic').child(uid);
  UploadTask uploadTask = ref.putData(
    profileImage,
    // SettableMetadata(contentType: 'image/jpg'),
  );
  TaskSnapshot snapshot = await uploadTask;
  String downLoadUrl = await snapshot.ref.getDownloadURL();
  return downLoadUrl;
}

void showModalBottomSheetA(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Modal Bottom Sheet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text(
                'This is a modal bottom sheet. You can dismiss it by swiping down or tapping outside.'),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        ),
      );
    },
  );
}
