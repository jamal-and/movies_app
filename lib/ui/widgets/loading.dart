import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/ui/styles/colors.dart';

import '../styles/decoration.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitThreeBounce(
      size: horizontalSpacing * 1.5,
      duration: const Duration(milliseconds: 800),
      itemBuilder: (context, index) {
        return DecoratedBox(
          decoration: circleDecoration(
            color: index.isEven ? AppColors.primary : AppColors.accent,
          ),
        );
      },
    );
  }
}
