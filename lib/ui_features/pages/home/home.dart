import 'package:flutter/material.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/ui_features/pages/home/fragment/admin_fragment.dart';
import 'package:ukost/ui_features/pages/home/fragment/customer_fragment.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (storage.account?.role == Role.customer) {
      return const CustomerFragment();
    }

    return const AdminFragment();
  }
}
