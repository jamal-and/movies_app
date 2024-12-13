import 'package:get/get.dart';
import 'package:movies/ui/screens/home/home_screen.dart';
import 'package:movies/ui/screens/movie/movie_screen.dart';
import 'package:movies/ui/screens/movie_list/movie_list_screen.dart';
import 'package:movies/ui/screens/splash/splash_screen.dart';

const String routeSplash = '/';
const String routeHome = '/home';
const String routeProductDetails = '/movieDetails';
const String routeMovieList = '/movieList';

List<GetPage> routes = [
  GetPage(
    name: routeSplash,
    page: () => const SplashScreen(),
  ),
  GetPage(
    name: routeHome,
    page: () => const HomeScreen(),
  ),
  GetPage(
    name: routeProductDetails,
    page: () => const MovieDetailsScreen(),
  ),
  GetPage(
    name: routeMovieList,
    page: () => const MovieListScreen(),
  ),
];
