import 'package:get/get.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var isLoggedIn = false.obs;
  var currentUser = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final token = await StorageService.getToken();
    final email = await StorageService.getEmail();

    if (token != null && email != null) {
      currentUser.value = User(email: email, token: token);
      isLoggedIn.value = true;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await ApiService.register(email, password);
      final token = response['access_token'];

      await StorageService.saveToken(token);
      await StorageService.saveEmail(email);

      currentUser.value = User(email: email, token: token);
      isLoggedIn.value = true;

      Get.snackbar('Success', 'Registration successful');
      Get.offAllNamed('/pets');
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await ApiService.login(email, password);
      final token = response['access_token'];

      await StorageService.saveToken(token);
      await StorageService.saveEmail(email);

      currentUser.value = User(email: email, token: token);
      isLoggedIn.value = true;

      Get.snackbar('Success', 'Login successful');
      Get.offAllNamed('/pets');
    } catch (e) {
      Get.snackbar('Error', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await StorageService.clearStorage();
    currentUser.value = null;
    isLoggedIn.value = false;
    Get.offAllNamed('/login');
  }

  String? get token => currentUser.value?.token;
}
