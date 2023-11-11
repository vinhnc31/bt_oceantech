import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class employeeManager {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addEmployee(String name, String email, String phone) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        // Lưu thông tin nhân viên với userId
        await _firestore.collection("Employees").add(
            {"UserId": userId, "name": name, "email": email, "phone": phone});
      }

      return true; // Thành công
    } catch (e) {
      print("Thêm lỗi...............$e");
      return false; // Thất bại
    }
  }

  Future<bool> updateEmployee(
      String employeeId, String name, String email, String phone) async {
    try {
      await _firestore
          .collection("Employees")
          .doc(employeeId)
          .update({"name": name, "email": email, "phone": phone});
      return true; // Thành công
    } catch (e) {
      print("Update lỗi...............$e");
      return false; // Thất bại
    }
  }

  Future<bool> deleteEmployee(String employeeId) async {
    try {
      await _firestore.collection("Employees").doc(employeeId).delete();
      return true; // Thành công
    } catch (e) {
      print("Delete lỗi...............$e");
      return false; // Thất bại
    }
  }
}
