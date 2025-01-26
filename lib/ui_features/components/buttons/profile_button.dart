import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    this.onTap,
    this.path,
  });
  final Function()? onTap;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorAsset.violet,
                image: path != null
                    ? DecorationImage(
                        image: NetworkImage(path!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          if (onTap != null)
            Align(
              alignment: Alignment.bottomRight,
              child: Material(
                borderRadius: BorderRadius.circular(100),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: onTap,
                  child: Ink(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: ColorAsset.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: ColorAsset.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
