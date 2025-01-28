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
import 'package:ukost/ui_features/components/forms/form_user.dart';

class FormUserManagement extends StatefulWidget {
  final bool isEditMode;
  final Map<String, dynamic>? existingData;

  const FormUserManagement({
    super.key,
    this.isEditMode = false,
    this.existingData,
  });

  @override
  State<FormUserManagement> createState() => _FormUserManagement();
}

class _FormUserManagement extends State<FormUserManagement> {
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneController = TextEditingController(),
      dobController = TextEditingController(),
      passwordController = TextEditingController(),
      roleController = TextEditingController(),
      identityNumberController = TextEditingController();

  String? gender;
  File? profilePicture;
  File? identityCard;

  @override
  void initState() {
    super.initState();
    if (widget.isEditMode && widget.existingData != null) {
      nameController.text = widget.existingData?['name'] ?? '';
      emailController.text = widget.existingData?['email'] ?? '';
      phoneController.text = widget.existingData?['phone'] ?? '';
      dobController.text = widget.existingData?['date_of_birth'] ?? '';
      gender = widget.existingData?['gender'];
      roleController.text = widget.existingData?['role'] ?? '';
      identityNumberController.text =
          widget.existingData?['identity_number'] ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEditMode ? "Edit Pengguna" : "Tambah Pengguna"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FormUser(
          path: widget.existingData?['profile_picture_path'],
          profilePicture: profilePicture,
          gender: gender,
          dobController: dobController,
          emailController: emailController,
          nameController: nameController,
          phoneController: phoneController,
          identityNumberController: identityNumberController,
          onChangeGender: (selectedGender) {
            setState(() {
              gender = selectedGender;
            });
          },
          onChangeDate: () async {
            var selectedDate = await DatePicker.getDatePicker(
              dobController.text.isNotEmpty ? dobController.text : null,
              lastDate: 1940,
            );
            if (selectedDate != null) {
              setState(() {
                dobController.text =
                    DateFormatter.date(selectedDate, "yyyy-MM-dd");
              });
            }
          },
          onProfilePicture: () async {
            var pickedFile =
                await FilePickerHelper.pickFile(fileType: FileType.image);
            if (pickedFile.isNotEmpty) {
              setState(() {
                profilePicture = pickedFile.first;
              });
            }
          },
          onAttachIdentity: (file) {
            setState(() {
              identityCard = file;
            });
          },
          onCancelAttach: () {
            setState(() {
              identityCard = null;
            });
          },
          onSubmit: (formData) {
            Modals().confirmation(
              title: widget.isEditMode
                  ? "Simpan Perubahan?"
                  : "Tambahkan Pengguna?",
              onTap: () async {
                loading.value = true;

                if (profilePicture != null) {
                  formData["profile_picture"] =
                      await MultipartFile.fromFile(profilePicture!.path);
                }
                if (identityCard != null) {
                  formData["identity_card"] =
                      await MultipartFile.fromFile(identityCard!.path);
                }

                formData["password"] = passwordController.text;
                formData["role"] = roleController.text;
                formData["identity_number"] = identityNumberController.text;

                dynamic response;

                if (widget.isEditMode) {
                  response = await UserRepository.update(
                    widget.existingData?['id'],
                    formData,
                  );
                } else {
                  response = await UserRepository.add(formData);
                }

                loading.value = false;

                if (response != null) {
                  if (widget.isEditMode) {
                    storage.copyWith(account: response);
                  }
                  Navigator.pop(context, response);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
