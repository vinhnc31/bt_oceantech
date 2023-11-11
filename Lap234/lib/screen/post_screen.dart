import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';

import '../helper/image_helper.dart';
import '../servites/post_manager_servites.dart';
import '../widget/text_input.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _post =
      FirebaseFirestore.instance.collection("Posts");
  PostManager post = PostManager();
  Uint8List? _image;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  Future<void> selectImage() async {
    final image = await pickerImage(ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  void savePost() async {
    String title = _titleController.text;
    String content = _contentController.text;

    EasyLoading.show(status: 'loading...');
    bool postAdded = await post.addPost(title, content, _image!);

    if (postAdded) {
      EasyLoading.showToast('Add post successfully');
      Navigator.of(context).pop();
      clear();
    } else {
      EasyLoading.showToast('Add post fail');
      Navigator.of(context).pop();
      clear();
    }
    EasyLoading.dismiss();
  }

  void deletePost(String postId) async {
    EasyLoading.show(status: 'loading...');

    final result = await post.deletePost(postId);
    if (result) {
      EasyLoading.showToast('Delete employee successfully');
      Navigator.of(context).pop();
    } else {
      EasyLoading.showToast('Delete employee failed');
      Navigator.of(context).pop();
    }
    EasyLoading.dismiss();
  }

  void clear() {
    _contentController.clear();
    _titleController.clear();
  }

  void _showAddPost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () => selectImage(),
                  child: _image != null
                      ? Image.memory(
                          _image!,
                          width: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "https://www.pngitem.com/pimgs/m/21-217644_camera-fotografica-png-vector-transparent-png.png",
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _titleController,
                  hintText: "Enter the title.....",
                  labelText: "Title",
                ),
                SizedBox(
                  height: 20,
                ),
                TextInput(
                  controller: _contentController,
                  hintText: "Enter the Content.....",
                  labelText: "Content",
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: savePost,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 24),
                    ))
              ],
            ),
          ));
        });
  }

  void _showDeletePost([DocumentSnapshot? documentSnapshot]) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  "Are you sure you want to delete it?",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "If you delete it, you will not be able to restore the data.",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => deletePost(documentSnapshot!.id),
                    child: Text("DELETE")),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("CANCEL")),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purpleAccent,
            title: Text(
              "POST",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            actions: [
              IconButton(onPressed: _showAddPost, icon: Icon(Icons.add,size: 35,color: Colors.white,))
            ],
          ),
      body: StreamBuilder(
        stream: _post.where('UserId', isEqualTo: user?.uid).snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      snapshot.data!.docs[index];
                  return Card(
                      elevation: 4,
                      margin: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              // Màu của shadow
                              spreadRadius: 2,
                              // Điều chỉnh độ lan rộng của shadow
                              blurRadius: 4,
                              // Điều chỉnh độ mờ của shadow
                              offset:
                                  Offset(0, 2), // Điều chỉnh vị trí của shadow
                            ),
                          ],
                        ),
                        child: ListTile(
                          title: Row(
                            children: [
                              CircleAvatar(
                                child:
                                    Image.network(documentSnapshot["imageUrl"]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Text(
                                    documentSnapshot["title"],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                  Text(
                                    documentSnapshot["content"],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black54),
                                  )
                                ],
                              ),
                              SizedBox(width: 150,),
                              IconButton(
                                  onPressed: () =>
                                      _showDeletePost(documentSnapshot),
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    ));
  }
}
