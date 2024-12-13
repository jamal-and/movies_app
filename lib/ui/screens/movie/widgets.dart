import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/core/helpers/ui_helper.dart';
import 'package:movies/ui/screens/movie/movie_view_model.dart';
import 'package:movies/ui/styles/colors.dart';
import 'package:movies/ui/styles/decoration.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    super.key,
    required this.movieDetails,
  });

  final Map movieDetails;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: getImagePath(
            movieDetails['backdrop_path'],
            width: 'original',
          ),
          height: kDeviceHeight * 0.4,
          width: kDeviceWidth,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withOpacity(0.8),
                AppColors.black.withOpacity(0.5),
                AppColors.black.withOpacity(0.2),
                AppColors.black.withOpacity(0),
              ],
            ),
          ),
          child: SafeArea(
            child: GetBuilder(builder: (MovieViewModel movieViewModel) {
              return Row(
                children: [
                  generalSmallBox,
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: circleDecoration(
                        color: AppColors.black.withOpacity(0.7),
                      ),
                      padding: EdgeInsets.all(horizontalSpacing / 2),
                      child: const Icon(CupertinoIcons.back),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      movieViewModel.addToFav();
                    },
                    icon: Icon(
                      movieViewModel.isFav
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      movieViewModel.addToWatchlist();
                    },
                    icon: Icon(movieViewModel.isWatchlist
                        ? CupertinoIcons.clock_fill
                        : CupertinoIcons.clock),
                  ),
                  generalSmallBox,
                ],
              );
            }),
          ),
        ),
        Positioned(
          bottom: verticalSpacing / 2,
          left: horizontalSpacing / 2,
          child: Container(
            decoration: cardDecoration(
              color: AppColors.black.withOpacity(0.75),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: horizontalSpacing / 2,
              vertical: verticalSpacing / 2,
            ),
            child: Row(
              children: [
                generalSmallBox,
                const Icon(
                  CupertinoIcons.star_fill,
                  color: Colors.amber,
                ),
                generalSmallBox,
                Text(
                  movieDetails['vote_average'].toStringAsFixed(1),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                generalSmallBox,
              ],
            ),
          ),
        )
      ],
    );
  }
}
