import 'package:flutter/material.dart';

double screenWidth(BuildContext context, [double? width]) =>
    MediaQuery.of(context).size.width * (width != null ? (width / 100) : 1);

double screenHeight(BuildContext context, [double? height]) =>
    MediaQuery.of(context).size.height * (height != null ? (height / 100) : 1);

SizedBox verticalSpace(double height) => SizedBox(
      height: height,
    );

SizedBox horizontalSpace(double width) => SizedBox(
      width: width,
    );
