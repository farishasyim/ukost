import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/ui_features/components/appbar/appbar_primary.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/card/expanse_card.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomerFragment extends StatefulWidget {
  const CustomerFragment({super.key});

  @override
  State<CustomerFragment> createState() => _CustomerFragmentState();
}

class _CustomerFragmentState extends State<CustomerFragment> {
  List<Transaction> transactions = [];

  Future<void> init() async {
    transactions = await FinanceRepository.getIncome(TransactionStatus.unpaid);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      init();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await init();
      },
      child: ListView(
        children: [
          AppBarPrimary(
            height: null,
            title: "Selamat Datang,",
            subtitle: storage.account?.name ?? "",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: ColorAsset.violet,
            ),
          ),
          verticalSpace(10),
          const HorizontalText(
            title: "Tagihan anda",
            trailing: "",
          ),
          verticalSpace(10),
          SizedBox(
            height: 70,
            width: screenWidth(context),
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 20),
              children: [
                for (var row in transactions)
                  ExpanseCard(
                    path: row.pivotRoom?.user?.profileLink,
                    onTap: () {
                      showModalBottomSheet(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 20,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: "Anda memiliki tagihan sebesar ",
                                    children: [
                                      TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                ", segera lakukan pembayaran bila sudah segera konfirmasi kepada admin!",
                                            style: GoogleFonts.inter(
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                        text: row.price?.toCurrency(),
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: GoogleFonts.inter(),
                                ),
                                verticalSpace(10),
                                Text(
                                  "*Jatuh tempo pada tanggal ${DateFormatter.date(row.dueDate)}",
                                  style: GoogleFonts.inter(
                                    color: ColorAsset.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                verticalSpace(20),
                                PrimaryButton(
                                  onTap: () {
                                    var phoneNumber = "6281223896063";
                                    launchUrl(Uri.parse(
                                      "https://wa.me/$phoneNumber",
                                    ));
                                  },
                                  radius: 8,
                                  color: ColorAsset.violet,
                                  label: "Konfirmasi Pembayaran",
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    title:
                        DateFormatter.monthYear(row.startPeriod, "MMMM yyyy"),
                    subtitle: (row.price ?? 0).toCurrency(),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
