import 'dart:ui';

double pixelRatio = window.devicePixelRatio;

/// Size in physical pixels
Size physicalScreenSize = window.physicalSize;
double physicalWidth = physicalScreenSize.width;
double physicalHeight = physicalScreenSize.height;

/// Size in logical pixels
Size logicalScreenSize = window.physicalSize / pixelRatio;
final double screenRatio = (logicalScreenSize.height / logicalScreenSize.width);
// ignore: avoid_bool_literals_in_conditional_expressions

///  ignore: duplicate_ignore
double kDeviceWidth = logicalScreenSize.width;
double kDeviceHeight = logicalScreenSize.height;
