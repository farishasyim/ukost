import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/repositories/room/room_repository.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/ui_features/pages/room_management/detail_room.dart';
import 'package:ukost/ui_features/pages/room_management/form_category.dart';

class DetailCategoryPage extends StatefulWidget {
  const DetailCategoryPage({super.key, required this.category});
  final Category category;
  @override
  State<DetailCategoryPage> createState() => _DetailCategoryPageState();
}

class _DetailCategoryPageState extends State<DetailCategoryPage> {
  late Category category;

  @override
  void initState() {
    super.initState();
    category = widget.category;
  }

  Future<void> refresh() async {
    var res = await CategoryRepository.show(category.id!);
    if (res != null) {
      setState(() {
        category = res;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await refresh();
      },
      child: Scaffold(
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
                    onTap: () {
                      nextScreen(
                        FormCategoryPage(
                          category: category,
                          onSuccess: () async {
                            Modals().loading();
                            var res =
                                await CategoryRepository.show(category.id!);
                            backScreen();
                            if (res != null) {
                              setState(() {
                                category = res;
                              });
                            } else {
                              backScreen();
                            }
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Ubah",
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    onTap: () {
                      Modals(context).confirmation(
                        onTap: () async {
                          Modals().loading();
                          var res = await CategoryRepository.deleteCategory(
                              category.id!);
                          backScreen();
                          if (res) {
                            backScreen();
                          }
                        },
                      );
                    },
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
              category.imageLink!,
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
                    category.name ?? "",
                    style: GoogleFonts.inter(
                      color: ColorAsset.violet,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    (category.price ?? 0).toCurrency(),
                    style: GoogleFonts.inter(
                      color: ColorAsset.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpace(5),
                  Text(
                    category.description ?? "",
                    style: GoogleFonts.inter(
                      color: ColorAsset.black,
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    color: ColorAsset.black.withOpacity(0.2),
                  ),
                  Text(
                    "Jumlah Kamar: ${category.rooms.length}",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: ColorAsset.black,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpace(10),
                  for (var row in category.rooms)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () async {
                          Modals().loading();
                          var res = await RoomRepository.show(row.id!);
                          backScreen();
                          if (res != null) {
                            nextScreen(
                              DetailRoomPage(
                                room: res,
                              ),
                            );
                          }
                        },
                        trailing: Container(
                          height: 5,
                          width: 5,
                          decoration: BoxDecoration(
                            color: row.pivot != null
                                ? ColorAsset.red
                                : ColorAsset.success,
                            shape: BoxShape.circle,
                          ),
                        ),
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
                        subtitle: row.pivot != null
                            ? Text(
                                row.pivot?.user?.name ?? "",
                              )
                            : null,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
