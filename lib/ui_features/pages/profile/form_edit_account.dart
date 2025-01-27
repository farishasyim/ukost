import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/file_picker.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/session_manager.dart';
import 'package:ukost/ui_features/components/forms/form_user.dart';

class FormEditAccountPage extends StatefulWidget {
  const FormEditAccountPage({super.key});

  @override
  State<FormEditAccountPage> createState() => _FormEditAccountPageState();
}

class _FormEditAccountPageState extends State<FormEditAccountPage> {
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneController = TextEditingController(),
      dobController = TextEditingController();
  String? gender;
  File? profilePicture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text = storage.account?.name ?? "";
    emailController.text = storage.account?.email ?? "";
    dobController.text =
        DateFormatter.date(storage.account?.dateOfBirth, "yyyy-MM-dd");
    phoneController.text = storage.account?.phone ?? "";
    gender = storage.account?.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profil"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          FormUser(
            onChangeGender: (e) {
              setState(() {
                gender = e;
              });
            },
            onSubmit: (e) {
              Modals().confirmation(
                onTap: () async {
                  loading.value = true;
                  if (profilePicture != null) {
                    e["profile_picture"] =
                        await MultipartFile.fromFile(profilePicture!.path);
                  }
                  var res = await UserRepository.update(storage.account?.id, e);
                  loading.value = false;
                  if (res != null) {
                    storage.copyWith(account: res);
                    SessionManager.setSession();
                    setState(() {
                      profilePicture = null;
                    });
                  }
                },
              );
            },
            path: storage.account?.profileLink,
            profilePicture: profilePicture,
            onProfilePicture: () async {
              var pick =
                  await FilePickerHelper.pickFile(fileType: FileType.image);
              if (pick.isNotEmpty) {
                setState(() {
                  profilePicture = pick.first;
                });
              }
            },
            gender: gender,
            onChangeDate: () async {
              var res = await DatePicker.getDatePicker(
                dobController.text.isNotEmpty ? dobController.text : null,
                lastDate: 1940,
              );
              if (res != null) {
                setState(() {
                  dobController.text = DateFormatter.date(res, "yyyy-MM-dd");
                });
              }
            },
            dobController: dobController,
            emailController: emailController,
            nameController: nameController,
            phoneController: phoneController,
          ),
        ],
      ),
    );
  }
}
