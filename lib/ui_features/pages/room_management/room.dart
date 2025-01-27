import 'package:flutter/material.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/app/repositories/room/room_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/buttons/button_add.dart';
import 'package:ukost/ui_features/components/card/room_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/pages/room_management/detail_category.dart';
import 'package:ukost/ui_features/pages/room_management/detail_room.dart';
import 'package:ukost/ui_features/pages/room_management/form_category.dart';
import 'package:ukost/ui_features/pages/room_management/form_room.dart';

class RoomPage extends StatefulWidget {
  const RoomPage({super.key});

  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  List<Category> categories = [];

  Future<void> init() async {
    categories = await CategoryRepository.getCategory();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await init();
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(60),
                    for (var category in categories)
                      Column(
                        children: [
                          HorizontalText(
                            title: category.name,
                            trailing: "Detil",
                            onTap: () async {
                              Modals().loading();
                              var res =
                                  await CategoryRepository.show(category.id!);
                              backScreen();
                              if (res != null) {
                                nextScreen(DetailCategoryPage(
                                  category: res,
                                ));
                              }
                            },
                          ),
                          verticalSpace(10),
                          SizedBox(
                            height: 200,
                            width: screenWidth(context),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 20),
                              children: [
                                for (var room in category.rooms)
                                  RoomCard(
                                    path: category.imageLink,
                                    onTap: () async {
                                      Modals().loading();
                                      var res =
                                          await RoomRepository.show(room.id!);
                                      backScreen();
                                      if (res != null) {
                                        nextScreen(
                                          DetailRoomPage(
                                            room: res,
                                          ),
                                        );
                                      }
                                    },
                                    onLongPress: () {
                                      Modals(context).action(
                                        onDelete: () {},
                                        onEdit: () {
                                          nextScreen(
                                            FormRoomPage(
                                              category: category,
                                              room: room,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    title: room.name,
                                    subtitle: room.pivot != null
                                        ? "Tidak Tersedia"
                                        : "Tersedia",
                                  ),
                                ButtonAdd(
                                  onTap: () {
                                    nextScreen(
                                      FormRoomPage(
                                        category: category,
                                        onSuccess: () {
                                          init();
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    verticalSpace(60),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: screenHeight(context) * 0.88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppBarPrimary(
                    title: "Manajemen Kamar",
                    trailing: SizedBox(),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: FloatingActionButton(
                        heroTag: "room",
                        onPressed: () {
                          nextScreen(
                            FormCategoryPage(
                              onSuccess: () {
                                init();
                              },
                            ),
                          );
                        },
                        backgroundColor: ColorAsset.violet,
                        child: Icon(
                          Icons.add_rounded,
                          color: ColorAsset.white,
                        ),
                      ),
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
