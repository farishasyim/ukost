import 'package:flutter/material.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/card/user_card.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppBarPrimary(
              title: "User Management",
              trailing: SizedBox(
                height: 60,
              ),
            ),
            for (var i = 0; i < 3; i++)
              const UserCard(
                title: "Pengguna A",
                subtitle: "Kamar 201",
                active: true,
              ),
          ],
        ),
      ),
    );
  }
}
