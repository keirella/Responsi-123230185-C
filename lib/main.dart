import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:responsi/controllers/auth_controller.dart';
import 'package:responsi/controllers/cart_controller.dart';
import 'package:responsi/controllers/product_controller.dart';
import 'package:responsi/models/cart_item_model.dart';
import 'package:responsi/pages/login_page.dart';
import 'package:responsi/pages/main_page.dart';
import 'package:responsi/services/cart_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(CartItemAdapter());
  }
  
  if (!Hive.isBoxOpen(CartService.boxName)) {
    await Hive.openBox<CartItemModel>(CartService.boxName);
  }

  Get.put(AuthController());
  Get.put(ProductController());
  Get.put(CartController());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '🌸Online Shop🌸',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFE08295)),
        useMaterial3: true,
      ),
      home: Obx(
        () {
          if (authController.isLoading.value) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          return authController.username.value.isEmpty
              ? const LoginPage()
              : const MainPage();
        },
      ),
    );
  }
}