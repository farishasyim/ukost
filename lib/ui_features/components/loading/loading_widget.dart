import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(
          0.5), // Memberikan latar belakang transparan untuk loading
      body: Center(
        child: CircularProgressIndicator(
          color: ColorAsset.violetLight,
        ),
      ),
    );
  }
}
