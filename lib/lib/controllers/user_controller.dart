import 'dart:typed_data';

import 'package:get/get.dart';

import '../models/user_model.dart';

class UserController extends GetxController {
  final Rx<UserModel> user = UserModel(
    id: 1,
    name: 'Aneeza Mustafa',
    email: 'aneezamustafa18@gmail.com',
  ).obs;

  final Rxn<Uint8List> profileImageBytes = Rxn<Uint8List>();

  void updateName(String newName) {
    if (newName.trim().isEmpty) {
      return;
    }

    user.value = UserModel(
      id: user.value.id,
      name: newName.trim(),
      email: user.value.email,
    );
  }

  void updateProfileImage(Uint8List imageBytes) {
    profileImageBytes.value = imageBytes;
  }
}