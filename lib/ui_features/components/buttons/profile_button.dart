import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    this.onTap,
    this.path,
    this.profilePicture,
  });
  final Function()? onTap;
  final String? path;
  final File? profilePicture;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: 120,
      child: FittedBox(
        child: Stack(
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorAsset.violet,
                image: profilePicture != null
                    ? DecorationImage(
                        image: FileImage(profilePicture!),
                        fit: BoxFit.cover,
                      )
                    : path != null
                        ? DecorationImage(
                            image: NetworkImage(path!),
                            fit: BoxFit.cover,
                          )
                        : null,
              ),
            ),
            if (onTap != null)
              Positioned(
                right: 0,
                bottom: 0,
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
      ),
    );
  }
}
