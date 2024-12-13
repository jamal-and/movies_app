import 'package:flutter/material.dart';
import 'package:movies/core/helpers/sizes.dart';

// General Spacing (for Padding and Margin)

final double horizontalSpacing = kDeviceWidth * 0.05;
final double verticalSpacing = kDeviceHeight * 0.02;

// Widgets Measures

final double fullWidthButtonHeight = kDeviceHeight * 0.065;

final generalPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing,
  horizontal: horizontalSpacing,
);

final inputPadding = EdgeInsets.symmetric(
  vertical: verticalSpacing / 2,
  horizontal: horizontalSpacing,
);

const Duration generalDuration = Duration(milliseconds: 400);

final generalRadius = BorderRadius.circular(horizontalSpacing);
