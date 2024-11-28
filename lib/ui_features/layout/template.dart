import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/ui_features/components/bottom/bottom_navigation.dart';
import 'package:ukost/ui_features/pages/home/home.dart';
import 'package:ukost/ui_features/pages/profile/profile.dart';
import 'package:ukost/ui_features/pages/user_management/user.dart';

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
    UserPage(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.white,
      bottomNavigationBar: BottomNavigation(
        onTap: (e) {
          setState(() {
            index = e;
          });
        },
        index: index,
      ),
      body: widgets[index],
    );
  }
}
