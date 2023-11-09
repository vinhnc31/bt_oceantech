import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Lap1(),
    );
  }
}

class UserItem {
  String name;
  String age;
  String address;

  UserItem({required this.name, required this.age, required this.address});
}

class Lap1 extends StatefulWidget {
  const Lap1({super.key});

  @override
  State<Lap1> createState() => _Lap1State();
}

class _Lap1State extends State<Lap1> {
  List<UserItem> user = [];

  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  void _addUser() {
    setState(() {
      user.add(UserItem(
          name: _nameController.text,
          age: _ageController.text,
          address: _addressController.text));
    });
    _nameController.clear();
    _ageController.clear();
    _addressController.clear();
    Navigator.of(context).pop();
  }

  void _updateUser(int index) {
    setState(() {
      user[index].name = _nameController.text;
      user[index].age = _ageController.text;
      user[index].address = _addressController.text;
    });
    _nameController.clear();
    _ageController.clear();
    _addressController.clear();
    Navigator.of(context).pop();
  }

  void _deleteUser(int index) {
    setState(() {
      user.removeAt(index);
      Navigator.of(context).pop();
    });
  }

  void addUserItem() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Create User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                    labelText: 'Enter the name.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Name cannot be empty '
                        : null;
                  },
                  controller: _nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.add_reaction),
                    hintText: 'Age',
                    labelText: 'Enter the age.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Age cannot be empty '
                        : null;
                  },
                  controller: _ageController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.add_reaction),
                    hintText: 'Address',
                    labelText: 'Enter the address.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Address cannot be empty '
                        : null;
                  },
                  controller: _addressController,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: _addUser,
                        child: Text(
                          "Add",
                          style: TextStyle(color: Colors.black),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  void _UpdateUserItem(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Update User"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                    labelText: 'Enter the name.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Name cannot be empty '
                        : null;
                  },
                  controller: _nameController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.add_reaction),
                    hintText: 'Age',
                    labelText: 'Enter the age.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Age cannot be empty '
                        : null;
                  },
                  controller: _ageController,
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.add_reaction),
                    hintText: 'Address',
                    labelText: 'Enter the address.......',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black, // Màu của border
                        width: 2.0, // Độ dày của border
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                  validator: (String? value) {
                    return (value != null && value.isEmpty)
                        ? 'Address cannot be empty '
                        : null;
                  },
                  controller: _addressController,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () => _updateUser(index),
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.black),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.black),
                        ))
                  ],
                )
              ],
            ),
          );
        });
  }

  void _deleteUserItem(int index) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  "Notification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Are you sure you want to delete?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w100),
                ),
              ],
            ),
            content: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () => _deleteUser(index),
                    child: Text(
                      "Delete",
                      style: TextStyle(color: Colors.red),
                    )),
                ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: TextStyle(color: Colors.black),
                    ))
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
          "Lap 1",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: user.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      user[index].name,
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          user[index].age,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          user[index].address,
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          _nameController.text = user[index].name;
                          _ageController.text = user[index].age;
                          _addressController.text = user[index].address;
                          _UpdateUserItem(index);
                        },
                        icon: Icon(
                          Icons.edit_document,
                          size: 45,
                          color: Colors.purple,
                        )),
                    IconButton(
                        onPressed: () => _deleteUserItem(index),
                        icon: Icon(
                          Icons.delete_forever,
                          size: 45,
                          color: Colors.red,
                        )),
                  ],
                )
              ],
            ));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: addUserItem,
        backgroundColor: Colors.purpleAccent,
        child: Icon(Icons.add),
      ),
    ));
  }
}
