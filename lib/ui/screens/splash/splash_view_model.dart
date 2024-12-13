import 'dart:async';

import 'package:get/get.dart';
import 'package:movies/core/api/api_constants.dart';
import 'package:movies/core/api/api_paths.dart';
import 'package:movies/core/api/api_request.dart';
import 'package:movies/routes.dart';

class SplashViewModel extends GetxController {
  @override
  void onInit() {
    List movies = [];
    super.onInit();
    ApiRequest(
      path: pathMoviesPopular,
      method: getMethod,
      formatResponse: true,
    ).request(
      onSuccess: (data, response) {
        movies = response['results'];
      },
    );
    Future.delayed(0.seconds).then(
      (value) {
        if (movies.isEmpty) {
          // If movies is empty then data not loaded, we wait 1 second and check again
          Timer.periodic(
            1.seconds,
            (timer) {
              if (movies.isNotEmpty) {
                timer.cancel();
                Get.offAllNamed(routeHome, arguments: movies);
              }
            },
          );
        } else {
          Get.offAllNamed(routeHome, arguments: movies);
        }
      },
    );
  }
}
