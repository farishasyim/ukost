import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/ui_features/pages/home/home.dart';

class TemplatePage extends StatefulWidget {
  const TemplatePage({super.key});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int index = 0;
  List<Widget> widgets = const [
    HomePage(),
    Placeholder(),
    Placeholder(),
    Placeholder(),
  ];
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> menus = [
      {
        "icon": Icons.home_rounded,
        "label": "",
      },
      {
        "icon": Icons.notifications_rounded,
        "label": "",
      },
      {
        "icon": Icons.note_alt_rounded,
        "label": "",
      },
      {
        "icon": Icons.person_rounded,
        "label": "",
      },
    ];
    return Scaffold(
      backgroundColor: ColorAsset.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (e) {
          setState(() {
            index = e;
          });
        },
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
              label: e["label"],
            ),
          )
        ],
        currentIndex: index,
      ),
      body: widgets[index],
    );
  }
}
