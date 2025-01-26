import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/number_extension.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({super.key, required this.category});
  final Category category;
  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.white,
      appBar: AppBar(
        title: const Text(
          "Detil Kategori Kamar",
        ),
        actions: [
          PopupMenuButton(
            color: ColorAsset.white,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    "Ubah",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    "Hapus",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ];
            },
          ),
        ],
        backgroundColor: ColorAsset.white,
      ),
      body: ListView(
        children: [
          Image.network(
            widget.category.imageLink!,
            height: 250,
            width: screenWidth(context),
            fit: BoxFit.cover,
          ),
          verticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.category.name ?? "",
                  style: GoogleFonts.inter(
                    color: ColorAsset.violet,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  (widget.category.price ?? 0).toCurrency(),
                  style: GoogleFonts.inter(
                    color: ColorAsset.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                verticalSpace(5),
                Text(
                  widget.category.description ?? "",
                  style: GoogleFonts.inter(
                    color: ColorAsset.black,
                    fontSize: 12,
                  ),
                ),
                Divider(
                  color: ColorAsset.black.withOpacity(0.2),
                ),
                Text(
                  "Jumlah Kamar: ${widget.category.rooms.length}",
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    color: ColorAsset.black,
                    fontSize: 14,
                  ),
                ),
                verticalSpace(10),
                for (var row in widget.category.rooms)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(
                          color: ColorAsset.black.withOpacity(0.2),
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      dense: true,
                      title: Text(
                        row.name ?? "",
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
