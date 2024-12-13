import 'package:get/get.dart';
import 'package:movies/core/api/api_constants.dart';
import 'package:movies/core/api/api_paths.dart';
import 'package:movies/core/api/api_request.dart';
import 'package:movies/core/helpers/messages.dart';
import 'package:movies/ui/screens/home/home_view_model.dart';

class MovieViewModel extends GetxController {
  int movieId = Get.arguments;
  Map? movieDetails;
  bool isFav = false;
  bool isWatchlist = false;

  @override
  void onInit() {
    super.onInit();
    getMovieData();
  }

  void checkFavAndWathclistStatus() {
    isFav = homeViewModel.favMovies.firstWhereOrNull(
            (element) => element['id'] == movieDetails!['id']) !=
        null;
    isWatchlist = homeViewModel.watchlistMovies.firstWhereOrNull(
            (element) => element['id'] == movieDetails!['id']) !=
        null;
  }

  HomeViewModel homeViewModel = Get.find<HomeViewModel>();
  void getMovieData() {
    movieDetails = homeViewModel.cachedMovies[movieId];
    if (movieDetails == null) {
      ApiRequest(
        path: '/movie/$movieId',
        method: getMethod,
        formatResponse: true,
        queryParameters: {
          'append_to_response': 'credits',
        },
      ).request(
        onSuccess: (data, response) {
          movieDetails = response;
          checkFavAndWathclistStatus();
          update();
          // Saving movie details to cachedMovies
          homeViewModel.addToCachedMovie(movieDetails!);
        },
      );
    } else {
      checkFavAndWathclistStatus();
    }
  }

  void addToFav() {
    ApiRequest(path: pathAddToFav, method: postMethod, body: {
      'media_id': movieDetails!['id'],
      'media_type': "movie",
      'favorite': !isFav,
    }).request(
      onSuccess: (data, response) {
        showSuccessMessage(message: 'Added to favorite');
        isFav = !isFav;
        update();
        homeViewModel.refreshData();
      },
    );
  }

  void addToWatchlist() {
    ApiRequest(path: pathAddToWatchlist, method: postMethod, body: {
      'media_id': movieDetails!['id'],
      'media_type': "movie",
      'watchlist': !isWatchlist,
    }).request(
      onSuccess: (data, response) {
        showSuccessMessage(message: 'Added to favorite');
        isWatchlist = !isWatchlist;
        update();
        homeViewModel.refreshData();
      },
    );
  }
}
