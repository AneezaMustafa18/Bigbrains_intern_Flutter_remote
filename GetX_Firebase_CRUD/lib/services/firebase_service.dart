import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // =========================
  // CURRENT USER UID
  // =========================

  String get currentUserId {
    final User? user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    return user.uid;
  }

  // =========================
  // CREATE - Add User
  // =========================

  Future<void> addUser(UserModel user) async {
    final String uid = currentUserId;

    final UserModel userWithOwner = UserModel(
      id: user.id,
      ownerId: uid,
      name: user.name,
      email: user.email,
      age: user.age,
    );

    await _firestore.collection('users').add(
      userWithOwner.toMap(),
    );
  }

  // =========================
  // READ - Get Current User's Users
  // =========================

  Stream<List<UserModel>> getUsers() {
    final String uid = currentUserId;

    return _firestore
        .collection('users')
        .where('ownerId', isEqualTo: uid)
        .snapshots()
        .map(
          (snapshot) {
        return snapshot.docs.map(
              (doc) {
            return UserModel.fromMap(
              doc.id,
              doc.data(),
            );
          },
        ).toList();
      },
    );
  }

  // =========================
  // UPDATE - Update User
  // =========================

  Future<void> updateUser(UserModel user) async {
    if (user.id.isEmpty) {
      throw Exception('User ID is missing.');
    }

    await _firestore
        .collection('users')
        .doc(user.id)
        .update(
      user.toMap(),
    );
  }

  // =========================
  // DELETE - Delete User
  // =========================

  Future<void> deleteUser(String userId) async {
    if (userId.isEmpty) {
      throw Exception('User ID is missing.');
    }

    await _firestore
        .collection('users')
        .doc(userId)
        .delete();
  }
}