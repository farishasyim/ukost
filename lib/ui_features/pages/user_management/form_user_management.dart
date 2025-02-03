import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/category/category_repository.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/file_picker.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/forms/form_user.dart';

class FormUserManagement extends StatefulWidget {
  final User? user;

  const FormUserManagement({
    super.key,
    this.user,
  });

  @override
  State<FormUserManagement> createState() => _FormUserManagement();
}

class _FormUserManagement extends State<FormUserManagement> {
  TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneController = TextEditingController(),
      dobController = TextEditingController(),
      identityNumberController = TextEditingController();

  String? gender;
  File? profilePicture;
  File? identityCard;
  List<String> availableRooms = [];
  String? selectedRoom;

  @override
  void initState() {
    super.initState();
    _fetchAvailableRooms();
    if (widget.user != null) {
      nameController.text = widget.user?.name ?? '';
      emailController.text = widget.user?.email ?? '';
      phoneController.text = widget.user?.phone ?? '';
      dobController.text = widget.user?.dateOfBirth != null
          ? DateFormatter.date(widget.user?.dateOfBirth, "yyyy-MM-dd")
          : "";
      gender = widget.user?.gender;
      identityNumberController.text =
          (widget.user?.identityNumber ?? "").toString();
      selectedRoom = widget.user?.room?.name;
    }
  }

  void _fetchAvailableRooms() async {
    var categories = await CategoryRepository.getCategory();
    List<String> rooms = [];
    for (var category in categories) {
      for (var room in category.rooms) {
        if (room.pivot == null || room.name == selectedRoom) {
          rooms.add(room.name ?? "");
        }
      }
    }
    setState(() {
      availableRooms = rooms;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title:
              Text(widget.user != null ? "Edit Pengguna" : "Tambah Pengguna"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FormUser(
            path: widget.user?.profileLink,
            profilePicture: profilePicture,
            gender: gender,
            identityCardPicture: widget.user?.identityCardLink,
            dobController: dobController,
            emailController: emailController,
            nameController: nameController,
            phoneController: phoneController,
            identityNumberController: identityNumberController,
            rooms: availableRooms,
            selectedRoom: selectedRoom,
            onSelectRoom: (room) {
              setState(() {
                selectedRoom = room;
              });
            },
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
                title: widget.user != null
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
                  formData["identity_number"] = identityNumberController.text;
                  formData["room"] = selectedRoom;

                  User? user;

                  if (widget.user != null) {
                    user = await UserRepository.update(
                      widget.user?.id,
                      formData,
                    );
                  } else {
                    user = await UserRepository.store(formData);
                  }

                  loading.value = false;

                  if (user != null) {
                    backScreen();
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
