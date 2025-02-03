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
        child: ListView(
          children: [
            const CircleAvatar(
              radius: 50,
              // backgroundImage: NetworkImage(user.profilePictureUrl),
            ),
            verticalSpace(20),
            _buildTextField(label: "Nama", initialValue: user.name ?? ''),
            _buildTextField(label: "Telepon", initialValue: user.phone ?? ''),
            _buildTextField(label: "Email", initialValue: user.email ?? ''),
            _buildTextField(label: "Gender", initialValue: user.gender ?? ''),
            _buildTextField(
                label: "Tanggal Lahir",
                initialValue:
                    user.dateOfBirth?.toLocal().toString().split(' ')[0] ?? ''),
            _buildTextField(
                label: "NIK",
                initialValue: user.identityNumber?.toString() ?? ''),
            _buildTextField(
                label: "Ruangan", initialValue: user.room?.toString() ?? ''),
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

  Widget _buildTextField(
      {required String label, required String initialValue}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 40, // tinggi TextField
            child: TextFormField(
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
              initialValue: initialValue,
              readOnly: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
