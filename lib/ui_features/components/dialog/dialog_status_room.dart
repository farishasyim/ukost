import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/export.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/pages/user_management/select_user.dart';

class StatusRoomDialog extends StatefulWidget {
  const StatusRoomDialog({
    super.key,
    this.onTap,
    this.checkin = true,
  });
  final Function(Map<String, dynamic>)? onTap;
  final bool checkin;

  @override
  State<StatusRoomDialog> createState() => StatusRoomDialogState();
}

class StatusRoomDialogState extends State<StatusRoomDialog> {
  TextEditingController date = TextEditingController();
  User? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Dialog(
        backgroundColor: ColorAsset.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.checkin)
                TextFieldPrimary(
                  readOnly: true,
                  controller: TextEditingController(text: user?.name ?? ""),
                  onTap: () async {
                    Modals().loading();
                    var res = await UserRepository.getUser(
                      userStatus: UserStatus.available,
                    );
                    backScreen();
                    nextScreen(SelectUserPage(
                      onTap: (e) {
                        setState(() {
                          user = e;
                        });
                      },
                      user: user,
                      users: res,
                    ));
                  },
                  hintText: "Masukan pengguna",
                  label: "Pengguna",
                ),
              TextFieldPrimary(
                controller: date,
                readOnly: true,
                onTap: () async {
                  var pick = await DatePicker.getDatePicker(
                      date.text.isEmpty ? null : date.text);
                  if (pick != null) {
                    setState(() {
                      date.text = DateFormatter.date(pick, "yyyy-MM-dd");
                    });
                  }
                },
                hintText:
                    "Masukan ${widget.checkin ? "tanggal daftar" : "tanggal keluar"}",
                label: widget.checkin ? "Tanggal masuk" : "Tanggal keluar",
              ),
              verticalSpace(5),
              PrimaryButton(
                label: "Submit",
                color: ColorAsset.violet,
                radius: 8,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    backScreen();
                    if (widget.onTap != null) {
                      Map<String, dynamic> request = {};
                      if (widget.checkin) {
                        request["customer_id"] = user?.id;
                        request["date"] = date.text;
                      } else {
                        request["left_at"] = date.text;
                      }
                      widget.onTap!(request);
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
