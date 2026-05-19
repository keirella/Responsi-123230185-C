import 'package:get/get.dart';
import 'package:responsi/pages/main_page.dart';
import '../services/auth_services.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final username = ''.obs;
  final isLoading = true.obs;
  final isLoggingIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkSession();
  }

  Future<void> checkSession() async {
    isLoading.value = true;
    final loggedIn = await _authService.isLoggedIn();
    username.value = loggedIn ? await _authService.getUsername() : '';
    isLoading.value = false;
  }

  Future<void> login(String inputUsername, String password) async {
    isLoggingIn.value = true;
    final success = await _authService.login(inputUsername, password);
    isLoggingIn.value = false;

    if (!success) {
      Get.snackbar('Login gagal', 'Username minimal 5 karakter & password harus 3 digit NIM.');
      return;
    }

    username.value = inputUsername.trim();
    Get.offAll(() => const MainPage());
  }

  Future<void> logout() async {
    await _authService.logout();
    username.value = '';
  }
}