import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/ui/screens/movie_list/movie_list_viewmodel.dart';
import 'package:movies/ui/widgets/movies_widgets.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Movies'),
      ),
      body: GetBuilder(
        init: MovieListViewmodel(),
        builder: (MovieListViewmodel movieViewModel) {
          return ListView.builder(
            itemCount: movieViewModel.movies.length,
            controller: movieViewModel.scrollController,
            padding: EdgeInsets.symmetric(
              horizontal: horizontalSpacing,
              vertical: verticalSpacing / 2,
            ),
            itemBuilder: (context, index) {
              Map item = movieViewModel.movies[index];

              return SizedBox(
                height: kDeviceHeight * 0.2,
                child: MovieBackdropWidget(item: item),
              );
            },
          );
        },
      ),
    );
  }
}
