import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/core/helpers/ui_helper.dart';
import 'package:movies/routes.dart';
import 'package:movies/ui/screens/home/home_view_model.dart';
import 'package:movies/ui/styles/colors.dart';
import 'package:movies/ui/styles/decoration.dart';
import 'package:movies/ui/widgets/movies_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel homeViewModel = Get.put(HomeViewModel());
    return Scaffold(
      body: Stack(
        children: [
          GetBuilder(
            builder: (HomeViewModel controller) {
              Map item = controller.movies[controller.currentMovieIndex];
              return AnimatedSwitcher(
                duration: 1.seconds,
                child: CachedNetworkImage(
                  imageUrl: getImagePath(item['poster_path']),
                  key: Key(item.toString()),
                  height: kDeviceHeight,
                  width: kDeviceWidth,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              color: AppColors.black.withOpacity(0.7),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: Row(
                    children: [
                      const Text(
                        'Top Rated',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      CupertinoButton(
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              //   fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.cyan),
                        ),
                        onPressed: () {
                          Get.toNamed(routeMovieList);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: kDeviceHeight * 0.3,
                  child: PageView.builder(
                    controller: PageController(viewportFraction: 0.8),
                    onPageChanged: homeViewModel.onMovieChanged,
                    itemCount: homeViewModel.movies.length,
                    itemBuilder: (context, index) {
                      Map item = homeViewModel.movies[index];
                      return MovieBackdropWidget(item: item);
                    },
                  ),
                ),
                generalSmallBox,

                // **** Favoirte ****
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: const Text(
                    'Favorite Movies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder(
                  builder: (HomeViewModel homeViewModel) {
                    return MovieListWidget(movieList: homeViewModel.favMovies);
                  },
                ),
                generalSmallBox,

                // **** Wathclist ****
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalSpacing),
                  child: const Text(
                    'Wathclist Movies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GetBuilder(builder: (HomeViewModel homeViewModel) {
                  return MovieListWidget(
                    movieList: homeViewModel.watchlistMovies,
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
