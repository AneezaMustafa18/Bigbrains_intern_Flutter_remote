import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../services/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();
  final ImagePicker _imagePicker = ImagePicker();

  final name = ''.obs;
  final email = ''.obs;
  final photoUrl = ''.obs;

  final isLoading = false.obs;
  final isSaving = false.obs;
  final isUploadingPhoto = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  // =========================
  // LOAD PROFILE
  // =========================

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      final user = _profileService.currentUser;

      if (user == null) {
        Get.snackbar(
          'Not Logged In',
          'Please login first.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      email.value = user.email ?? '';

      final profile = await _profileService.getProfile();

      if (profile.exists) {
        final data = profile.data();

        name.value = data?['name'] ?? '';
        photoUrl.value = data?['photoUrl'] ?? '';
      } else {
        name.value = user.displayName ?? '';
      }
    } catch (e) {
      Get.snackbar(
        'Profile Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // SAVE NAME
  // =========================

  Future<void> saveName(String newName) async {
    final trimmedName = newName.trim();

    if (trimmedName.isEmpty) {
      Get.snackbar(
        'Invalid Name',
        'Please enter your name.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      isSaving.value = true;

      await _profileService.updateName(trimmedName);

      name.value = trimmedName;

      Get.back();

      Get.snackbar(
        'Profile Updated',
        'Your name has been updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Update Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isSaving.value = false;
    }
  }

  // =========================
  // PICK IMAGE
  // =========================

  Future<void> pickProfileImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1000,
      );

      if (pickedFile == null) {
        return;
      }

      await uploadProfileImage(pickedFile);
    } catch (e) {
      Get.snackbar(
        'Image Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  // =========================
  // UPLOAD IMAGE
  // =========================

  Future<void> uploadProfileImage(XFile imageFile) async {
    try {
      isUploadingPhoto.value = true;

      final url =
      await _profileService.uploadProfilePhoto(imageFile);

      photoUrl.value = url;

      Get.snackbar(
        'Photo Updated',
        'Your profile photo has been updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Upload Failed',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    } finally {
      isUploadingPhoto.value = false;
    }
  }

  // =========================
  // LOGOUT
  // =========================

  Future<void> logout() async {
    await _profileService.logout();
  }
}