import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    this.index = 0,
    required this.onTap,
  });
  final Function(int) onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menus = [];

    if (storage.account?.role == Role.admin) {
      menus = [
        {
          "icon": Icons.home_rounded,
          "label": "Utama",
        },
        {
          "icon": Icons.receipt_long_rounded,
          "label": "Transaksi",
        },
        {
          "icon": Icons.bed_rounded,
          "label": "Ruangan",
        },
        {
          "icon": Icons.people_alt_rounded,
          "label": "Pengguna",
        },
        {
          "icon": Icons.person_rounded,
          "label": "Profil",
        },
      ];
    } else {
      menus = [
        {
          "icon": Icons.home_rounded,
          "label": "Utama",
        },
        {
          "icon": Icons.receipt_long_rounded,
          "label": "Transaksi",
        },
        {
          "icon": Icons.person_rounded,
          "label": "Profil",
        },
      ];
    }
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: onTap,
      backgroundColor: ColorAsset.violet,
      selectedItemColor: ColorAsset.white,
      unselectedItemColor: ColorAsset.black.withOpacity(0.4),
      items: [
        ...menus.map(
          (e) => BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: index == menus.indexOf(e) ? ColorAsset.red : null,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(
                e["icon"],
              ),
            ),
            label: "",
            tooltip: e["label"],
          ),
        )
      ],
      currentIndex: index,
    );
  }
}
