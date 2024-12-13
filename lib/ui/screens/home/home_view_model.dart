import 'package:get/get.dart';
import 'package:movies/core/api/api_constants.dart';
import 'package:movies/core/api/api_paths.dart';
import 'package:movies/core/api/api_request.dart';

class HomeViewModel extends GetxController {
  List movies = [];
  List favMovies = [];
  List watchlistMovies = [];

  int currentMovieIndex = 0;

  // To save movie details so we don't need to send api request every time we open it
  Map cachedMovies = {};

  onMovieChanged(int index) {
    currentMovieIndex = index;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    movies = Get.arguments;
    refreshData();
  }

  void addToCachedMovie(Map item) {
    cachedMovies[item['id']] = item;
  }

  void getFavorites() {
    ApiRequest(path: pathFavoirteMovies, method: getMethod).request(
      onSuccess: (data, response) {
        favMovies = response['results'];
        update();
      },
    );
  }

  void getWatchList() {
    ApiRequest(path: pathWatchListeMovies, method: getMethod).request(
      onSuccess: (data, response) {
        watchlistMovies = response['results'];
        update();
      },
    );
  }

  void refreshData() {
    getFavorites();
    getWatchList();
  }
}
