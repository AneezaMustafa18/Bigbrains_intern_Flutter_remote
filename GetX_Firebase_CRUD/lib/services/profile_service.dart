import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Current logged-in user
  User? get currentUser => _auth.currentUser;

  // =========================
  // GET PROFILE
  // =========================

  Future<DocumentSnapshot<Map<String, dynamic>>> getProfile() async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    return await _firestore
        .collection('profiles')
        .doc(user.uid)
        .get();
  }

  // =========================
  // CREATE PROFILE
  // =========================

  Future<void> createProfile({
    required String name,
    required String email,
  }) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    await _firestore
        .collection('profiles')
        .doc(user.uid)
        .set(
      {
        'name': name,
        'email': email,
        'photoUrl': '',
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // =========================
  // UPDATE NAME
  // =========================

  Future<void> updateName(String name) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    await _firestore
        .collection('profiles')
        .doc(user.uid)
        .set(
      {
        'name': name,
        'email': user.email ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );
  }

  // =========================
  // UPLOAD PROFILE PHOTO
  // =========================

  Future<String> uploadProfilePhoto(XFile imageFile) async {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('No user is currently logged in.');
    }

    final bytes = await imageFile.readAsBytes();

    final storageRef = _storage
        .ref()
        .child('profile_images')
        .child('${user.uid}.jpg');

    await storageRef.putData(
      bytes,
      SettableMetadata(
        contentType: 'image/jpeg',
      ),
    );

    final downloadUrl = await storageRef.getDownloadURL();

    await _firestore
        .collection('profiles')
        .doc(user.uid)
        .set(
      {
        'photoUrl': downloadUrl,
        'email': user.email ?? '',
        'updatedAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return downloadUrl;
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    await _auth.signOut();
  }
}