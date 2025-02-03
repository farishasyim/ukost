import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/ui_features/components/buttons/multimedia_button.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/buttons/profile_button.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/components/radio/select_gender_radio.dart';

class FormUser extends StatelessWidget {
  const FormUser({
    super.key,
    this.path,
    required this.dobController,
    required this.emailController,
    this.gender,
    this.identityNumberController,
    required this.nameController,
    required this.phoneController,
    this.onChangeDate,
    this.onChangeGender,
    this.onAttachIdentity,
    this.onCancelAttach,
    this.onSubmit,
    this.onProfilePicture,
    this.profilePicture,
    this.identityCardPicture,
    this.selectedRoom,
    this.onSelectRoom,
    this.rooms,
  });
  final String? path, gender;
  final TextEditingController emailController,
      nameController,
      phoneController,
      dobController;
  final TextEditingController? identityNumberController;
  final Function(String?)? onChangeGender;
  final Function()? onChangeDate, onProfilePicture, onCancelAttach;
  final Function(File)? onAttachIdentity;
  final Function(Map<String, dynamic>)? onSubmit;
  final File? profilePicture;
  final String? identityCardPicture;

  final List<String>? rooms; // Daftar ruangan
  final String? selectedRoom; // Ruangan yang dipilih
  final Function(dynamic)?
      onSelectRoom; // Fungsi untuk menangani pemilihan ruangan

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ProfileButton(
          path: path,
          onTap: onProfilePicture,
          profilePicture: profilePicture,
        ),
        verticalSpace(10),
        TextFieldPrimary(
          controller: emailController,
          hintText: "Masukan email anda",
          label: "Email",
        ),
        TextFieldPrimary(
          controller: nameController,
          hintText: "Masukan nama anda",
          label: "Nama",
        ),
        TextFieldPrimary(
          controller: phoneController,
          hintText: "Masukan no handphone anda",
          label: "No handphone",
        ),
        TextFieldPrimary(
          controller: dobController,
          hintText: "Masukan tanggal lahir anda",
          label: "Tanggal lahir",
          readOnly: true,
          onTap: onChangeDate,
          prefixIcon: const Icon(Icons.calendar_month_rounded),
        ),
        SelectGenderRadio(
          value: gender,
          onChanged: onChangeGender,
        ),
        if (onAttachIdentity != null &&
            onCancelAttach != null &&
            identityNumberController != null &&
            rooms != null &&
            onSelectRoom != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(),
              const HorizontalText(
                title: "Pilih Ruangan",
                padding: EdgeInsets.zero,
              ),
              verticalSpace(5),
              DropdownButton<String>(
                value: selectedRoom,
                onChanged: (newValue) {
                  onSelectRoom!(newValue!); // Memilih ruangan
                },
                items: rooms!.map<DropdownMenuItem<String>>((String room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room),
                  );
                }).toList(),
              ),
              const HorizontalText(
                title: "Identitas",
                padding: EdgeInsets.zero,
              ),
              TextFieldPrimary(
                controller: identityNumberController,
                label: "No KTP/SIM",
                hintText: "Masukan nomer KTP/SIM pengguna",
              ),
              MultimediaButton(
                title: "Tambahkan Foto KTP/SIM",
                path: identityCardPicture,
                onTap: onAttachIdentity!,
                onCancel: onCancelAttach!,
              ),
            ],
          ),
        verticalSpace(20),
        ValueListenableBuilder(
          valueListenable: loading,
          builder: (context, value, _) {
            return PrimaryButton(
              radius: 8,
              color: ColorAsset.violet,
              onTap: () {
                Map<String, dynamic> request = {
                  "name": nameController.text,
                  "email": emailController.text,
                  "gender": gender,
                  "phone": phoneController.text,
                  "date_of_birth": dobController.text,
                  "room": selectedRoom, // Menambahkan data ruangan yang dipilih
                };
                if (onSubmit != null) {
                  onSubmit!(request);
                }
              },
              label: "Submit",
              loading: loading.value,
            );
          },
        ),
        verticalSpace(10),
      ],
    );
  }
}
