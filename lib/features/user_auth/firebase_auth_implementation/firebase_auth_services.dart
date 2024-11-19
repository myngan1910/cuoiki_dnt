import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast(message: 'Email này đã được đăng ký!');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Email hoặc mật khẩu không đúng!');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }

  Future<void> saveUserDetails({
    required String uid,
    required String fullName,
    required String email,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set({
        'userId': uid,
        'fullName': fullName,
        'email': email,
        'phoneNumber': phoneNumber,
        'address': address,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      showToast(message: 'Lưu thông tin người dùng thất bại: $e');
    }
  }
}
