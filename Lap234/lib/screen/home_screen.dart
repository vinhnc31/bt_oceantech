import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../servites/employee_manager_servites.dart';
import '../widget/text_input.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference _employee =
      FirebaseFirestore.instance.collection("Employees");
  final _formkey = GlobalKey<FormState>();
  employeeManager _manager = employeeManager();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  bool _isLoading = false;

  void clear() {
    _nameController.clear();
    _emailController.clear();
    _phoneController.clear();
  }

  void addEmployee() async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        EasyLoading.show(status: 'loading...');

        final result = await _manager.addEmployee(name, email, phone);
        if (result) {
          EasyLoading.showToast('Add employee successfully');
          Navigator.of(context).pop();
          clear();
        } else {
          EasyLoading.showToast('Add employee failed');
          Navigator.of(context).pop();
          clear();
        }
      } finally {
        setState(() {
          _isLoading = false;
        });

        EasyLoading.dismiss();
      }
    }
  }

  void updateEmployee(String employeeId) async {
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    if (_formkey.currentState!.validate()) {
      try {
        setState(() {
          _isLoading = true;
        });

        EasyLoading.show(status: 'loading...');

        final result =
            await _manager.updateEmployee(employeeId, name, email, phone);
        if (result) {
          EasyLoading.showToast('Update employee successfully');
          Navigator.of(context).pop();
          clear();
        } else {
          EasyLoading.showToast('Add employee failed');
          Navigator.of(context).pop();
          clear();
        }
      } finally {
        setState(() {
          _isLoading = false;
        });

        EasyLoading.dismiss();
      }
    }
  }

  void deleteEmployee(String employeeId) async {
    EasyLoading.show(status: 'loading...');

    final result = await _manager.deleteEmployee(employeeId);
    if (result) {
      EasyLoading.showToast('Delete employee successfully');
      Navigator.of(context).pop();
    } else {
      EasyLoading.showToast('Delete employee failed');
      Navigator.of(context).pop();
    }
    EasyLoading.dismiss();
  }

  void _showAddEmployee() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                "Add Employee",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Container(
                constraints: BoxConstraints(maxHeight: 325),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextInput(
                        controller: _nameController,
                        hintText: "Enter the name........",
                        labelText: "Name",
                        isShowpassword: false,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Name cannot be empty";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        controller: _emailController,
                        hintText: "Enter the email........",
                        labelText: "Email",
                        isShowpassword: false,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          final pattern =
                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
                          final regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value!)) {
                            return "Email is in wrong format";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        controller: _phoneController,
                        hintText: "Enter the phone.........",
                        labelText: "Phone",
                        isShowpassword: false,
                        textInputType: TextInputType.phone,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (!regExp.hasMatch(value!)) {
                            return 'Enter Valid Phone Number';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: addEmployee,
                              child: Text(
                                "ADD",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void _showUpdateEmployee([DocumentSnapshot? _documentSnapshop]) {
    if (_documentSnapshop != null) {
      _nameController.text = _documentSnapshop["name"];
      _emailController.text = _documentSnapshop["email"];
      _phoneController.text = _documentSnapshop["phone"];
    }
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                "Update Employee",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              content: Container(
                constraints: BoxConstraints(maxHeight: 325),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextInput(
                        controller: _nameController,
                        hintText: "Enter the name........",
                        labelText: "Name",
                        isShowpassword: false,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Name cannot be empty";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        controller: _emailController,
                        hintText: "Enter the email........",
                        labelText: "Email",
                        isShowpassword: false,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          final pattern =
                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$';
                          final regExp = RegExp(pattern);
                          if (!regExp.hasMatch(value!)) {
                            return "Email is in wrong format";
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextInput(
                        controller: _phoneController,
                        hintText: "Enter the phone.........",
                        labelText: "Phone",
                        isShowpassword: false,
                        textInputType: TextInputType.phone,
                        validator: (String? value) {
                          if (value != null && value.isEmpty) {
                            return "Email cannot be empty";
                          }
                          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                          RegExp regExp = new RegExp(pattern);
                          if (!regExp.hasMatch(value!)) {
                            return 'Enter Valid Phone Number';
                          }
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () =>
                                  updateEmployee(_documentSnapshop!.id),
                              child: Text(
                                "UPDATE",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              )),
                          SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(
                                "CANCEL",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  void _showDeleteEmployee([DocumentSnapshot? _documentSnapshot]) {
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
                    onPressed: () => deleteEmployee(_documentSnapshot!.id),
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
          "HOME",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: _showAddEmployee, icon: Icon(Icons.add,size: 35,color: Colors.white,))
        ],
      ),
      body: StreamBuilder(
        stream: _employee.where('UserId', isEqualTo: user?.uid).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];
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
                              Container(
                                width: 200,
                                child: Column(
                                  children: [
                                    Text(
                                      documentSnapshot['name'],
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      documentSnapshot['email'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      documentSnapshot['phone'],
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black54),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () =>
                                          _showUpdateEmployee(documentSnapshot),
                                      icon: Icon(
                                        Icons.edit,
                                        size: 35,
                                      )),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () =>
                                          _showDeleteEmployee(documentSnapshot),
                                      icon: Icon(
                                        Icons.delete_forever,
                                        size: 35,
                                        color: Colors.red,
                                      ))
                                ],
                              )
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
