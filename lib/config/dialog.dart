import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/loading/loading_widget.dart';

class Modals {
  BuildContext? context;
  Modals([context]);
  void loading() {
    showDialog(
      context: context ?? navigatorKey.currentContext!,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          height: 70,
          width: screenWidth(context) * 0.05,
          child: const LoadingWidget(),
        ),
      ),
    );
  }

  void confirmation({
    String? title,
    Function()? onTap,
  }) {
    showDialog(
      context: context ?? navigatorKey.currentContext!,
      builder: (context) {
        return Dialog(
          backgroundColor: ColorAsset.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_rounded,
                  size: screenWidth(context) * 0.2,
                  color: ColorAsset.black.withOpacity(0.4),
                ),
                Text(
                  title ?? "Apakah anda yakin?",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorAsset.black.withOpacity(0.6),
                  ),
                ),
                verticalSpace(20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          radius: 100,
                          color: ColorAsset.violet,
                          onTap: () {
                            backScreen();
                          },
                          label: "Batalkan",
                        ),
                      ),
                      horizontalSpace(10),
                      Expanded(
                        child: PrimaryButton(
                          color: ColorAsset.white,
                          textColor: ColorAsset.violet,
                          radius: 100,
                          onTap: () {
                            backScreen();
                            if (onTap != null) {
                              onTap();
                            }
                          },
                          label: "Iya, yakin",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
