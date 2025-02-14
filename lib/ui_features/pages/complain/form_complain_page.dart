import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ukost/app/models/complain/complain.dart';
import 'package:ukost/app/repositories/complain/complain_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/export.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/multiple_multimedia_button.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class FormComplainPage extends StatefulWidget {
  const FormComplainPage({super.key, this.complain});
  final Complain? complain;

  @override
  State<FormComplainPage> createState() => _FormComplainPageState();
}

class _FormComplainPageState extends State<FormComplainPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController(),
      descriptionController = TextEditingController();
  List<File> files = [];
  List<String> existed = [];
  List<String> deleted = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.complain != null) {
      titleController.text = widget.complain?.title ?? "";
      descriptionController.text = widget.complain?.description ?? "";
      existed = widget.complain!.photos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Komplain"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            children: [
              TextFieldPrimary(
                controller: titleController,
                label: "Judul",
                hintText: "Masukan judul keluhan",
              ),
              TextFieldPrimary(
                controller: descriptionController,
                maxLines: null,
                label: "Deskripsi",
                hintText: "Deskripsikan keluhan anda",
              ),
              verticalSpace(5),
              MultipleMultimediaButton(
                paths: existed,
                path: "complains",
                onDelete: (e) {
                  deleted.add(e);
                },
                onTap: (e) {
                  files = e;
                },
                title: "Upload Keluhan",
              ),
              verticalSpace(20),
              ValueListenableBuilder(
                valueListenable: loading,
                builder: (context, value, _) {
                  return PrimaryButton(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      if (formKey.currentState!.validate()) {
                        Modals().confirmation(
                          onTap: () async {
                            loading.value = true;
                            Map<String, dynamic> request = {
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "photos[]": [],
                            };
                            for (var row in files) {
                              request["photos[]"]
                                  .add(await MultipartFile.fromFile(row.path));
                            }
                            var res = false;
                            if (widget.complain == null) {
                              res = await ComplainRepository.storeComplain(
                                  request);
                            } else {
                              request["deleted[]"] = deleted;
                              res = await ComplainRepository.updateComplain(
                                  widget.complain!.id!, request);
                            }
                            loading.value = false;
                            if (res) {
                              backScreen();
                            }
                          },
                        );
                      }
                    },
                    loading: loading.value,
                    label: "Submit",
                    radius: 8,
                    color: ColorAsset.violet,
                  );
                },
              ),
              verticalSpace(10),
            ],
          ),
        ),
      ),
    );
  }
}
