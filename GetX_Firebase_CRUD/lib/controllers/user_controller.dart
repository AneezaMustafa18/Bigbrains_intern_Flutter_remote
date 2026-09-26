import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/firebase_service.dart';

class UserController extends GetxController {
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxList<UserModel> users = <UserModel>[].obs;

  final RxBool isLoading = true.obs;
  final RxBool isAdding = false.obs;
  final RxBool isUpdating = false.obs;
  final RxBool isDeleting = false.obs;

  StreamSubscription<List<UserModel>>? _usersSubscription;

  // =========================
  // FETCH USERS
  // =========================

  void fetchUsers() {
    _usersSubscription?.cancel();

    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      users.clear();
      isLoading.value = false;
      return;
    }

    isLoading.value = true;

    _usersSubscription = _firebaseService.getUsers().listen(
          (userList) {
        users.assignAll(userList);
        isLoading.value = false;
      },
      onError: (error) {
        isLoading.value = false;

        Get.snackbar(
          'Error',
          'Unable to fetch users.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade600,
          colorText: Colors.white,
        );
      },
    );
  }

  // =========================
  // STOP LISTENING
  // =========================

  void stopListening() {
    _usersSubscription?.cancel();
    _usersSubscription = null;

    users.clear();
    isLoading.value = true;
  }

  // =========================
  // CREATE - ADD USER
  // =========================

  Future<bool> addUser({
    required String name,
    required String email,
    required String age,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        age.trim().isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final int? parsedAge = int.tryParse(age.trim());

    if (parsedAge == null || parsedAge <= 0) {
      Get.snackbar(
        'Invalid Age',
        'Please enter a valid age.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      Get.snackbar(
        'Authentication Required',
        'Please login again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isAdding.value = true;

    try {
      final UserModel user = UserModel(
        ownerId: currentUser.uid,
        name: name.trim(),
        email: email.trim(),
        age: parsedAge,
      );

      await _firebaseService.addUser(user);

      Get.snackbar(
        'User Added Successfully',
        '${user.name} has been added.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (error) {
      Get.snackbar(
        'Something went wrong',
        'Unable to add user. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );

      return false;
    } finally {
      isAdding.value = false;
    }
  }

  // =========================
  // UPDATE USER
  // =========================

  Future<bool> updateUser({
    required String userId,
    required String name,
    required String email,
    required String age,
  }) async {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        age.trim().isEmpty) {
      Get.snackbar(
        'Missing Information',
        'Please fill in all fields.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final int? parsedAge = int.tryParse(age.trim());

    if (parsedAge == null || parsedAge <= 0) {
      Get.snackbar(
        'Invalid Age',
        'Please enter a valid age.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    final User? currentUser = _auth.currentUser;

    if (currentUser == null) {
      Get.snackbar(
        'Authentication Required',
        'Please login again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    isUpdating.value = true;

    try {
      final UserModel updatedUser = UserModel(
        id: userId,
        ownerId: currentUser.uid,
        name: name.trim(),
        email: email.trim(),
        age: parsedAge,
      );

      await _firebaseService.updateUser(updatedUser);

      final int index = users.indexWhere(
            (user) => user.id == userId,
      );

      if (index != -1) {
        users[index] = updatedUser;
        users.refresh();
      }

      return true;
    } catch (error) {
      Get.snackbar(
        'Update Failed',
        'Unable to update user. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );

      return false;
    } finally {
      isUpdating.value = false;
    }
  }

  // =========================
  // DELETE USER
  // =========================

  Future<bool> deleteUser(String userId) async {
    if (userId.isEmpty) {
      Get.snackbar(
        'Delete Failed',
        'User ID is missing.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );
      return false;
    }

    isDeleting.value = true;

    try {
      await _firebaseService.deleteUser(userId);

      users.removeWhere(
            (user) => user.id == userId,
      );

      Get.snackbar(
        'User Deleted',
        'User has been deleted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      return true;
    } catch (error) {
      Get.snackbar(
        'Delete Failed',
        'Unable to delete user. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade600,
        colorText: Colors.white,
      );

      return false;
    } finally {
      isDeleting.value = false;
    }
  }

  @override
  void onClose() {
    _usersSubscription?.cancel();
    super.onClose();
  }
}