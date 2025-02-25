import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/user_card.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/pages/user_management/detail_user.dart';
import 'package:ukost/ui_features/pages/user_management/form_user_management.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  User? selectedUser;
  TextEditingController keywordController = TextEditingController();

  Future<void> init() async {
    users = await UserRepository.getUser();
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(120),
                    for (var user in users)
                      UserCard(
                        onTap: () {
                          nextScreen(UserDetailPage(user: user));
                        },
                        path: user.profileLink,
                        active: user.pivot == null,
                        title: user.name ?? "",
                        subtitle:
                            user.pivot != null ? user.pivot?.room?.name : "-",
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
                  AppBarPrimary(
                    title: "Manajemen Pengguna",
                    trailing: const SizedBox(),
                    children: [
                      verticalSpace(10),
                      TextFieldPrimary(
                        controller: keywordController,
                        hintText: "Mencari nama pengguna",
                        isRaw: true,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            Modals().loading();
                            var res = await UserRepository.getUser(
                              keyword: keywordController.text,
                            );
                            backScreen();
                            if (res.isEmpty) {
                              Snackbar.error('Data tidak ditemukan');
                              return;
                            }
                            setState(() {
                              users = res;
                            });
                          },
                          icon: Icon(
                            Icons.search_rounded,
                            color: ColorAsset.black.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: FloatingActionButton(
                        heroTag: "user",
                        onPressed: () async {
                          await nextScreen(
                            const FormUserManagement(),
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
