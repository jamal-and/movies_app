import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/core/helpers/ui_helper.dart';
import 'package:movies/routes.dart';
import 'package:movies/ui/styles/colors.dart';
import 'package:movies/ui/styles/decoration.dart';

class MovieBackdropWidget extends StatelessWidget {
  const MovieBackdropWidget({
    super.key,
    required this.item,
  });

  final Map item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(routeProductDetails, arguments: item['id']);
      },
      child: Container(
        decoration: cardDecoration(),
        margin: EdgeInsets.symmetric(
          horizontal: horizontalSpacing / 2,
          vertical: verticalSpacing / 2,
        ),
        clipBehavior: Clip.hardEdge,
        width: kDeviceWidth * 0.3,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            CachedNetworkImage(
              imageUrl:
                  getImagePath(item['backdrop_path'] ?? item['poster_path']),
              width: kDeviceWidth,
              height: kDeviceHeight,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.black.withOpacity(0.7),
                    AppColors.black.withOpacity(0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              height: kDeviceHeight * 0.2,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item['title'],
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({
    super.key,
    required this.movieList,
  });

  final List movieList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kDeviceHeight * 0.2,
      child: movieList.isEmpty
          ? const Center(
              child: Text(
                'Add movies to show here',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
            )
          : ListView.builder(
              itemCount: movieList.length,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: horizontalSpacing / 4),
              itemBuilder: (context, index) {
                Map item = movieList[index];
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(routeProductDetails, arguments: item['id']);
                  },
                  child: Container(
                    decoration: cardDecoration(),
                    margin: EdgeInsets.symmetric(
                      horizontal: horizontalSpacing / 2,
                      vertical: verticalSpacing / 2,
                    ),
                    clipBehavior: Clip.hardEdge,
                    width: kDeviceWidth * 0.3,
                    child: CachedNetworkImage(
                      imageUrl: getImagePath(item['poster_path']),
                      width: kDeviceWidth,
                      height: kDeviceHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
