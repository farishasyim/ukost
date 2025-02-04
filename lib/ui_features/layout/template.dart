import 'package:flutter/material.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/ui_features/components/bottom/bottom_navigation.dart';
import 'package:ukost/ui_features/pages/finance/layout.dart';
import 'package:ukost/ui_features/pages/home/home.dart';
import 'package:ukost/ui_features/pages/profile/profile.dart';
import 'package:ukost/ui_features/pages/room_management/room.dart';
import 'package:ukost/ui_features/pages/user_management/user.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  int index = 0;
  List<Widget> widgets = const [
    HomePage(),
    FinanceLayout(),
    RoomPage(),
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
