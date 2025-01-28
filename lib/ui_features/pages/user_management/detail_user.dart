import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/user_management/form_user_management.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pengguna"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(user.profilePictureUrl),
            ),
            verticalSpace(20),
            Text("Nama: ${user.name}", style: const TextStyle(fontSize: 18)),
            Text("Telepon: ${user.phone}",
                style: const TextStyle(fontSize: 18)),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Navigasi ke halaman FormUserManagement untuk edit
                    await nextScreen(
                      FormUserManagement(
                        user: user,
                      ),
                    );
                  },
                  child: const Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    var res = await UserRepository.delete(user.id!);
                    if (res) {
                      backScreen();
                    }
                  },
                  child: const Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
