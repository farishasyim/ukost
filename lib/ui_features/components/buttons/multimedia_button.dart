import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/file_picker.dart';

class MultimediaButton extends StatefulWidget {
  const MultimediaButton({
    super.key,
    required this.onTap,
    required this.onCancel,
    this.path,
    this.title,
  });
  final Function(File) onTap;
  final Function() onCancel;
  final String? path, title;

  @override
  State<MultimediaButton> createState() => _MultimediaButtonState();
}

class _MultimediaButtonState extends State<MultimediaButton> {
  File? file;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: file == null
          ? () async {
              var pick = await FilePickerHelper.pickFile(
                fileType: FileType.image,
              );
              if (pick.isNotEmpty) {
                setState(() {
                  file = pick.first;
                });
                widget.onTap(file!);
              }
            }
          : null,
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          padding: EdgeInsets.all(file != null ? 0 : 20),
          decoration: BoxDecoration(
            color: ColorAsset.black.withOpacity(0.02),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorAsset.black.withOpacity(0.2),
            ),
          ),
          width: screenWidth(context),
          child: () {
            if (file != null) {
              return FittedBox(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Image.file(file!),
                    ),
                    IconButton(
                      onPressed: () {
                        widget.onCancel();
                        setState(() {
                          file = null;
                        });
                      },
                      icon: Container(
                        decoration: BoxDecoration(
                          color: ColorAsset.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.cancel_rounded,
                          color: ColorAsset.red,
                          size: screenWidth(context) * 0.1,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else if (widget.path != null) {
              return Image.network(widget.path!);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_a_photo_rounded,
                  color: ColorAsset.black.withOpacity(0.3),
                  size: screenWidth(context) * 0.15,
                ),
                verticalSpace(10),
                Text(
                  widget.title ?? "Tambahkan Foto Kamar",
                  style: GoogleFonts.inter(
                    color: ColorAsset.black.withOpacity(0.4),
                  ),
                ),
              ],
            );
          }(),
        ),
      ),
    );
  }
}
