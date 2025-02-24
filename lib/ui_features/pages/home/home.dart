import 'package:flutter/material.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/pages/auth/change_password.dart';
import 'package:ukost/ui_features/pages/home/fragment/admin_fragment.dart';
import 'package:ukost/ui_features/pages/home/fragment/customer_fragment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (context.mounted) {
      Future.delayed(const Duration(milliseconds: 700)).whenComplete(() {
        if (storage.account!.isDefault) {
          Modals().confirmation(
            title: "Apakah anda ingin mengganti password untuk keamanan data?",
            onTap: () {
              nextScreen(const ChangePasswordPage());
            },
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (storage.account?.role == Role.customer) {
      return const CustomerFragment();
    }

    return const AdminFragment();
  }
}
