import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/helpers/constants.dart';
import 'package:movies/core/helpers/sizes.dart';
import 'package:movies/core/helpers/ui_helper.dart';
import 'package:movies/ui/styles/decoration.dart';

class ActorWidget extends StatelessWidget {
  const ActorWidget({
    super.key,
    required this.item,
  });

  final Map item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: circleDecoration(),
            margin: EdgeInsets.symmetric(
              horizontal: horizontalSpacing / 2,
            ),
            child: CachedNetworkImage(
              imageUrl: getImagePath(
                item['profile_path'],
              ),
              width: kDeviceWidth * 0.2,
              height: kDeviceHeight,
            ),
          ),
        ),
        generalSmallBox,
        Text(item['name'])
      ],
    );
  }
}
