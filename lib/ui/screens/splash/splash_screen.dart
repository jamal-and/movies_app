import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/ui/screens/splash/splash_view_model.dart';
import 'package:movies/ui/widgets/loading.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashViewModel());
    return const Scaffold(
      body: Center(
        child: LoadingWidget(),
      ),
    );
  }
}
