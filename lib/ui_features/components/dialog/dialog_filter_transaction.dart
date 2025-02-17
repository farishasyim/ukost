import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/pages/user_management/select_user.dart';

class DialogFilterTransaction extends StatefulWidget {
  const DialogFilterTransaction({super.key, required this.onTap});
  final Function(Map<String, dynamic>) onTap;

  @override
  State<DialogFilterTransaction> createState() =>
      _DialogFilterTransactionState();
}

class _DialogFilterTransactionState extends State<DialogFilterTransaction> {
  User? user;
  List<bool> active = [true, true];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFieldPrimary(
            controller: TextEditingController(text: user?.name ?? ""),
            isRaw: true,
            onTap: () async {
              var res = await UserRepository.getUser();
              if (res.isNotEmpty) {
                nextScreen(
                  SelectUserPage(
                    onTap: (e) {
                      setState(() {
                        user = e;
                      });
                    },
                    user: user,
                    users: res,
                  ),
                );
              } else {
                Snackbar.error("Tidak ditemukan pengguna");
              }
            },
            readOnly: true,
            hintText: "Masukan nama pengguna",
            label: "Pengguna",
          ),
          verticalSpace(15),
          for (final (index, row) in ["Belum Lunas", "Lunas"].indexed)
            CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(row),
              value: active[index],
              onChanged: (e) {
                setState(() {
                  active[index] = !active[index];
                });
              },
            ),
          if (user != null) ...[
            verticalSpace(10),
            PrimaryButton(
              radius: 8,
              label: "Cari",
              color: ColorAsset.violet,
              onTap: () {
                List<String> status = [];
                if (active[0]) {
                  status.add("unpaid");
                }
                if (active[1]) {
                  status.add("paid");
                }
                Map<String, dynamic> request = {
                  "customer_id": user?.id,
                };
                if (status.isNotEmpty) {
                  request["status"] = status;
                }
                backScreen();
                widget.onTap(request);
              },
            ),
          ]
        ],
      ),
    );
  }
}
