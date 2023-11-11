import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class PostManager {
  Future<String> _uploadImage(String childName, Uint8List file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child(childName).child(fileName);
      UploadTask task = ref.putData(file);
      TaskSnapshot snapshot = await task;
      String url = await snapshot.ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Error uploading image: $e");
      throw e; // Rethrow the exception to propagate it to the caller
    }
  }

  Future<bool> addPost(String title, String content, Uint8List file) async {
    try {
      String imageUrl = await _uploadImage("post", file);
      print(file);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Save post information with userId
        await _firestore.collection("Posts").add({
          "UserId": userId,
          "title": title,
          "content": content,
          "imageUrl": imageUrl,
          "timestamp": FieldValue.serverTimestamp(), // Add timestamp
        });
        return true;
      } else {
        print("User is null.");
        return false;
      }
    } catch (e) {
      print("Error adding post: $e");
      return false;
    }
  }

  Future<bool> deletePost(String postId) async {
    try {
      await _firestore.collection("Posts").doc(postId).delete();
      return true;
    } catch (e) {
      print("lỗi rồi..........$e");
      return false;
    }
  }
}
