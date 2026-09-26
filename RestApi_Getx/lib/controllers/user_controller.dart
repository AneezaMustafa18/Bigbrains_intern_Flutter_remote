import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/user_service.dart';

class UserController extends GetxController {
  final UserService userService = UserService();

  // Users list
  final RxList<UserModel> users = <UserModel>[].obs;

  // Loading state
  final RxBool isLoading = false.obs;

  // Error message
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final fetchedUsers = await userService.getUsers();

      users.assignAll(fetchedUsers);
    } catch (e) {
      users.clear();
      errorMessage.value = 'Failed to load users';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshUsers() async {
    await fetchUsers();
  }
}