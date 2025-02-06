import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/file_picker.dart';

class MultipleMultimediaButton extends StatefulWidget {
  const MultipleMultimediaButton({
    super.key,
    required this.onTap,
    this.path,
    this.title,
  });
  final Function(List<File>) onTap;
  final String? path, title;

  @override
  State<MultipleMultimediaButton> createState() =>
      _MultipleMultimediaButtonState();
}

class _MultipleMultimediaButtonState extends State<MultipleMultimediaButton> {
  List<File> files = [];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        var pick = await FilePickerHelper.pickFile(
          fileType: FileType.image,
        );
        if (pick.isNotEmpty) {
          setState(() {
            files.addAll(pick);
          });
          widget.onTap(files);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Material(
        color: Colors.transparent,
        child: Ink(
          padding: EdgeInsets.all(files.isNotEmpty ? 0 : 20),
          decoration: BoxDecoration(
            color: ColorAsset.black.withOpacity(0.02),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: ColorAsset.black.withOpacity(0.2),
            ),
          ),
          width: screenWidth(context),
          height: 180,
          child: () {
            if (files.isNotEmpty) {
              return ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                children: [
                  for (var row in files)
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.file(
                            row,
                            fit: BoxFit.fitWidth,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                files.remove(row);
                              });
                              widget.onTap(files);
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: ColorAsset.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.cancel_rounded,
                                color: ColorAsset.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
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
