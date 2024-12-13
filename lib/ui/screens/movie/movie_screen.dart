import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/ui/screens/movie/movie_view_model.dart';
import 'package:movies/ui/screens/movie/widgets.dart';
import 'package:movies/ui/styles/decoration.dart';
import 'package:movies/ui/widgets/actor.dart';
import 'package:movies/ui/widgets/loading.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder(
        init: MovieViewModel(),
        builder: (MovieViewModel movieViewModel) {
          Map movieDetails = movieViewModel.movieDetails ?? {};
          return movieViewModel.movieDetails == null
              ? const LoadingWidget()
              : Column(
                  children: [
                    MovieDetailsHeader(movieDetails: movieDetails),
                    Expanded(
                      child: SingleChildScrollView(
                        child: SafeArea(
                          top: false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              generalBox,
                              // ** Title & Overview **
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing / 2,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movieDetails['title'],
                                      style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      movieDetails['overview'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w200,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              generalBox,

                              // **** ACTORS ****
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: horizontalSpacing / 2,
                                ),
                                child: const Text(
                                  'Actors:',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              generalSmallBox,
                              SizedBox(
                                height: kDeviceHeight * 0.1,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      movieDetails['credits']['cast'].length,
                                  itemBuilder: (context, index) {
                                    Map item =
                                        movieDetails['credits']['cast'][index];
                                    return item['profile_path'] != null
                                        ? ActorWidget(item: item)
                                        : const SizedBox();
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
