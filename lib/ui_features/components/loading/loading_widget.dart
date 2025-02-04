import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: ColorAsset.violet,
      ),
    );
  }
}
