import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ukost/app/models/category/category.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/multimedia_button.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class FormCategoryPage extends StatefulWidget {
  const FormCategoryPage({
    super.key,
    this.category,
    this.onSuccess,
  });
  final Function()? onSuccess;
  final Category? category;

  @override
  State<FormCategoryPage> createState() => _FormCategoryPageState();
}

class _FormCategoryPageState extends State<FormCategoryPage> {
  File? file;
  TextEditingController nameController = TextEditingController(),
      priceController = TextEditingController(),
      descriptionController = TextEditingController(),
      totalRoomController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      nameController.text = widget.category?.name ?? "";
      priceController.text = (widget.category?.price ?? 0).toString();
      descriptionController.text = widget.category?.description ?? "";
    }
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
          title: const Text("Kategori Kamar"),
          backgroundColor: ColorAsset.white,
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            TextFieldPrimary(
              controller: nameController,
              hintText: "Tambahkan nama kategori",
              label: "Nama kategori",
            ),
            TextFieldPrimary(
              controller: priceController,
              label: "Harga kategori",
              hintText: "Tambahkan harga kategori",
              keyboardType: TextInputType.number,
            ),
            TextFieldPrimary(
              controller: descriptionController,
              label: "Deskripsi",
              hintText: "Tambahkan deskripsi",
              maxLines: 3,
            ),
            if (widget.category == null)
              TextFieldPrimary(
                controller: totalRoomController,
                label: "Jumlah kamar",
                hintText: "Tambahkan jumlah kamar",
                keyboardType: TextInputType.number,
              ),
            Divider(
              color: ColorAsset.black.withOpacity(0.2),
            ),
            verticalSpace(10),
            MultimediaButton(
              path: widget.category?.imageLink,
              onTap: (e) {
                file = e;
              },
              onCancel: () {
                file = null;
              },
            ),
            verticalSpace(20),
            ValueListenableBuilder(
              valueListenable: loading,
              builder: (context, value, _) {
                return PrimaryButton(
                  loading: loading.value,
                  radius: 8,
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Modals().confirmation(
                      onTap: () async {
                        bool res = false;
                        FocusScope.of(context).unfocus();
                        loading.value = true;
                        Map<String, dynamic> request = {
                          "name": nameController.text,
                          "price": priceController.text,
                          "description": descriptionController.text,
                          "total_rooms": totalRoomController.text,
                        };
                        if (file != null) {
                          request["photo"] =
                              await MultipartFile.fromFile(file!.path);
                        }
                        if (widget.category != null) {
                          res = await CategoryRepository.updateCategory(
                              widget.category!.id!, request);
                        } else {
                          res = await CategoryRepository.storeCategory(request);
                        }
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
