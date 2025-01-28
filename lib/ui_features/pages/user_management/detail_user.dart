import 'package:flutter/material.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/user_management/form_user_management.dart';

class UserDetailPage extends StatelessWidget {
  final User user;

  const UserDetailPage({super.key, required this.user});

  bool? get success => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Pengguna"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(user.profilePictureUrl),
            ),
            verticalSpace(20),
            Text("Nama: ${user.name}", style: TextStyle(fontSize: 18)),
            Text("Telepon: ${user.phone}", style: TextStyle(fontSize: 18)),
            verticalSpace(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    // Navigasi ke halaman FormUserManagement untuk edit
                    await nextScreen(
                      FormUserManagement(
                        isEditMode: true,
                        existingData: {
                          'id': user.id,
                          'name': user.name,
                          'email': user.email,
                          'phone': user.phone,
                          // 'profile_picture_path': user.profilePictureUrl,
                        },
                      ),
                    );
                  },
                  child: Text("Edit"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Hapus data user
                    if (user.id != null) {
                      bool success = await UserRepository.delete(user.id!);
                      if (success == true) {
                        Navigator.pop(context); // Kembali ke halaman utama
                      } else {
                        // Tampilkan pesan gagal
                      }
                    } else {
                      // Tampilkan pesan gagal
                    }
                    if (success != null) {
                      Navigator.pop(context); // Kembali ke halaman utama
                    } else {
                      // Tampilkan pesan gagal
                    }
                  },
                  child: Text("Delete"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
