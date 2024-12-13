import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/api/api_constants.dart';
import 'package:movies/core/api/api_log.dart';
import 'package:movies/core/api/api_paths.dart';
import 'package:movies/core/api/api_request.dart';
import 'package:movies/ui/widgets/loading.dart';

class MovieListViewmodel extends GetxController {
  int cureentPage = 1;
  int maxPage = 1;
  List movies = [];
  ScrollController scrollController = ScrollController();

  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(scrollListener);
    getData();
  }

  getData() {
    ApiRequest(
      path: pathMoviesPopular,
      method: getMethod,
      queryParameters: {
        'page': cureentPage,
      },
    ).request(
      onSuccess: (data, response) {
        maxPage = response['total_pages'];
        movies.addAll(response['results']);
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
        isLoading = false;
        update();
      },
    );
  }

  void scrollListener() {
    if (cureentPage >= maxPage) {
      // check if reached to the max page
      return;
    }
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !isLoading) {
      isLoading = true;
      Get.dialog(const Dialog(
        child: SizedBox(height: 200, child: LoadingWidget()),
      ));
      cureentPage++;
      consoleLog('$cureentPage $maxPage');
      if (cureentPage <= maxPage) {
        getData();
      }
    }
  }
}
