import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/models/room/room.dart';
import 'package:ukost/app/repositories/room/room_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class FormRoomPage extends StatefulWidget {
  const FormRoomPage({
    super.key,
    required this.category,
    this.onSuccess,
    this.room,
  });
  final Function()? onSuccess;
  final Category category;
  final Room? room;

  @override
  State<FormRoomPage> createState() => _FormRoomPageState();
}

class _FormRoomPageState extends State<FormRoomPage> {
  File? file;
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = widget.room?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: ColorAsset.white,
        appBar: AppBar(
          title: Text(widget.category.name ?? "-"),
          backgroundColor: ColorAsset.white,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFieldPrimary(
              controller: nameController,
              hintText: "Tambahkan nama kamar",
              label: "Nama kamar",
            ),
            verticalSpace(10),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, _) {
                return PrimaryButton(
                  loading: loading.value,
                  radius: 8,
                  onTap: () {
                    Modals().confirmation(
                      onTap: () async {
                        FocusScope.of(context).unfocus();
                        loading.value = true;
                        Map<String, dynamic> request = {
                          "name": nameController.text,
                          "category_id": widget.category.id,
                        };
                        print(request);
                        var res = await RoomRepository.storeRoom(request);
                        loading.value = false;
                        if (res) {
                          backScreen();
                          if (widget.onSuccess != null) {
                            widget.onSuccess!();
                          }
                        }
                      },
                    );
                  },
                  color: ColorAsset.success,
                  label: "Kirim",
                );
              },
            ),
            verticalSpace(20),
          ],
        ),
      ),
    );
  }
}
