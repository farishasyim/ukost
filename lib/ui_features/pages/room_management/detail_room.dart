import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukost/app/models/room/room.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/app/repositories/room/room_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/number_extension.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/dialog/dialog_status_room.dart';

class DetailRoomPage extends StatefulWidget {
  const DetailRoomPage({super.key, required this.room});
  final Room room;
  @override
  State<DetailRoomPage> createState() => _DetailRoomPageState();
}

class _DetailRoomPageState extends State<DetailRoomPage> {
  late Room room;

  @override
  void initState() {
    super.initState();
    room = widget.room;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorAsset.white,
      appBar: AppBar(
        title: Text(
          room.category?.name ?? "",
        ),
        backgroundColor: ColorAsset.white,
      ),
      bottomNavigationBar: PrimaryButton(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatusRoomDialog(
                checkin: room.pivot == null,
                onTap: (e) async {
                  e["room_id"] = room.id;
                  if (room.pivot != null) {
                    e["customer_id"] = room.pivot?.customerId;
                  }
                  Modals().loading();
                  var res = await RoomRepository.pivotRoom(e);
                  backScreen();
                  if (res) {
                    var room = await RoomRepository.show(this.room.id!);
                    if (room != null) {
                      setState(() {
                        this.room = room;
                      });
                    }
                  }
                },
              );
            },
          );
        },
        color: ColorAsset.violet,
        label: room.pivot == null ? "Check In" : "Check Out",
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var res = await RoomRepository.show(room.id!);
          if (res != null) {
            setState(() {
              room = res;
            });
          }
        },
        child: ListView(
          children: [
            Image.network(
              room.category!.imageLink!,
              height: 250,
              width: screenWidth(context),
              fit: BoxFit.cover,
            ),
            verticalSpace(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    room.name ?? "",
                    style: GoogleFonts.inter(
                      color: ColorAsset.violet,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    (room.category?.price ?? 0).toCurrency(),
                    style: GoogleFonts.inter(
                      color: ColorAsset.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpace(5),
                  Text(
                    room.category?.description ?? "",
                    style: GoogleFonts.inter(
                      color: ColorAsset.black,
                      fontSize: 12,
                    ),
                  ),
                  Divider(
                    color: ColorAsset.black.withOpacity(0.2),
                  ),
                  if (room.pivot != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pemilik Kamar",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            color: ColorAsset.black,
                            fontSize: 14,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              room.pivot?.user?.name ?? "-",
                              style: GoogleFonts.inter(
                                color: ColorAsset.black,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              room.pivot?.user?.identityNumber == null &&
                                      room.pivot?.user?.identityCard == null
                                  ? "Data Belum Lengkap"
                                  : "Data Lengkap",
                              style: GoogleFonts.inter(
                                color: ColorAsset.black,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace(5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Masuk",
                              style: GoogleFonts.inter(
                                color: ColorAsset.black,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              DateFormatter.date(
                                room.pivot?.createdAt,
                                "dd/MM/yy",
                              ),
                              style: GoogleFonts.inter(
                                color: ColorAsset.success,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: ColorAsset.black.withOpacity(0.2),
                        ),
                      ],
                    ),
                  Text(
                    "Transaksi",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      color: ColorAsset.black,
                      fontSize: 14,
                    ),
                  ),
                  verticalSpace(10),
                  for (var row in room.transactions)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListTile(
                        onTap: () {
                          if (row.status == "paid") {
                            if (row.url == null) {
                              Snackbar.error(
                                  "Transaksi ini tidak memiliki foto bukti pembayaran");
                              return;
                            }

                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  child: Image.network(
                                    row.url!,
                                    headers: const {"Connection": "keep-alive"},
                                  ),
                                );
                              },
                            );
                          } else {
                            Modals().confirmation(
                              title:
                                  "Apakah anda yakin ingin mengirimkan tagihan kepada pengguna ini?",
                              onTap: () async {
                                Modals().loading();
                                var res = await FinanceRepository.sentInvoice(
                                    row.id!);
                                backScreen();
                                if (res) {
                                  Snackbar.message("Invoice berhasil dikirim");
                                }
                              },
                            );
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(
                            color: ColorAsset.black.withOpacity(0.2),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        dense: true,
                        title: Text(
                          "${row.pivotRoom?.user?.name ?? ""} | ${DateFormatter.date(row.startPeriod, "MMM yyyy")}",
                          style: GoogleFonts.inter(
                            color: row.status == "paid"
                                ? ColorAsset.black
                                : ColorAsset.red,
                          ),
                        ),
                        subtitle: Text(
                          row.date != null
                              ? DateFormatter.date(row.date, "dd/MM/yyyy")
                              : "Belum Lunas",
                          style: GoogleFonts.inter(
                            color: row.status == "paid"
                                ? ColorAsset.black
                                : ColorAsset.red,
                          ),
                        ),
                        trailing: Text(
                          (row.price ?? 0).toCurrency(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
