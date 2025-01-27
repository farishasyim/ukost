import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/navigation_services.dart';

class SelectUserPage extends StatelessWidget {
  const SelectUserPage({
    super.key,
    this.users = const [],
    this.user,
    required this.onTap,
  });
  final List<User> users;
  final User? user;
  final Function(User) onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.white,
      appBar: AppBar(
        backgroundColor: ColorAsset.white,
        title: const Text("Pilih pengguna"),
      ),
      body: ListView(
        children: [
          for (var row in users)
            RadioListTile<int>(
              controlAffinity: ListTileControlAffinity.trailing,
              groupValue: user?.id,
              title: Text(row.name ?? "-"),
              subtitle: Text(row.email ?? "-"),
              value: row.id!,
              onChanged: (e) {
                backScreen();
                onTap(row);
              },
            ),
        ],
      ),
    );
  }
}
