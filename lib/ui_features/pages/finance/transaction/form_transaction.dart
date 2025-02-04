import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ukost/app/models/transaction/transaction.dart';
import 'package:ukost/app/models/user/user.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/app/repositories/user/user_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/constant.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/config/snackbar.dart';
import 'package:ukost/ui_features/components/buttons/multimedia_button.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';
import 'package:ukost/ui_features/components/radio/select_active_invoice.dart';
import 'package:ukost/ui_features/pages/user_management/select_user.dart';

class FormTransactionPage extends StatefulWidget {
  const FormTransactionPage({
    super.key,
    this.transaction,
  });
  final Transaction? transaction;

  @override
  State<FormTransactionPage> createState() => _FormTransactionPageState();
}

class _FormTransactionPageState extends State<FormTransactionPage> {
  TextEditingController priceController = TextEditingController();
  File? file;
  DateTime? date;
  DateTime? time;
  User? user;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? status;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    priceController.text = (widget.transaction?.price ?? 0).toString();
    if (widget.transaction != null) {
      user = widget.transaction?.pivotRoom?.user;
      status = widget.transaction?.status;
      if (status == "paid") {
        date = widget.transaction?.date;
        time = DateTime(
          2020,
          1,
          1,
          widget.transaction!.date!.hour,
          widget.transaction!.date!.minute,
        );
      } else {
        date = widget.transaction?.createdAt;
        time = DateTime(
          2020,
          1,
          1,
          widget.transaction!.createdAt!.hour,
          widget.transaction!.createdAt!.minute,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Invoice"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            children: [
              TextFieldPrimary(
                controller: TextEditingController(
                  text: user != null
                      ? "${user?.name}, ${widget.transaction != null ? widget.transaction?.pivotRoom?.room?.category?.name : user?.pivot?.room?.category?.name} ${widget.transaction != null ? widget.transaction?.pivotRoom?.room?.name : user?.pivot?.room?.name}"
                      : "",
                ),
                label: "Pengguna",
                readOnly: true,
                onTap: widget.transaction == null
                    ? () async {
                        var res = await UserRepository.getUser(
                          userStatus: UserStatus.unavailable,
                        );
                        if (res.isNotEmpty) {
                          nextScreen(
                            SelectUserPage(
                              onTap: (e) {
                                setState(() {
                                  priceController.text =
                                      (e.pivot?.room?.category?.price ?? 0)
                                          .toString();
                                  user = e;
                                });
                              },
                              user: user,
                              users: res,
                            ),
                          );
                        } else {
                          Snackbar.error("Tidak ditemukan pengguna aktif");
                        }
                      }
                    : null,
                hintText: "Pilih data pengguna dan kamar",
              ),
              TextFieldPrimary(
                controller: priceController,
                label: "Harga",
                keyboardType: TextInputType.number,
                hintText: "Masukan harga kamar",
              ),
              SelectActiveInvoiceRadio(
                value: status,
                onChanged: widget.transaction?.status == "paid"
                    ? null
                    : (e) {
                        setState(() {
                          date = null;
                          time = null;
                          if (e == "unpaid" && widget.transaction != null) {
                            date = widget.transaction?.createdAt;
                            time = DateTime(
                              2020,
                              1,
                              1,
                              widget.transaction!.createdAt!.hour,
                              widget.transaction!.createdAt!.minute,
                            );
                          }
                          status = e;
                        });
                      },
              ),
              if (status != null) ...[
                TextFieldPrimary(
                  controller: TextEditingController(
                    text: date != null ? DateFormatter.date(date) : "",
                  ),
                  readOnly: true,
                  label: status == "paid"
                      ? "Tanggal Pembayaran"
                      : "Tanggal Terbit Invoice",
                  onTap: () async {
                    var date = await DatePicker.getDatePicker(
                        this.date?.toIso8601String());
                    if (date != null) {
                      setState(() {
                        this.date = date;
                      });
                    }
                  },
                  hintText: status == "paid"
                      ? "Masukan tanggal pembayaran"
                      : "Masukan tanggal tagihan",
                ),
                TextFieldPrimary(
                  readOnly: true,
                  onTap: () async {
                    var time = await DatePicker.getTimePicker(this.time);
                    if (time != null) {
                      setState(() {
                        this.time =
                            DateTime(2020, 1, 1, time.hour, time.minute);
                      });
                    }
                  },
                  controller: TextEditingController(
                    text: time != null ? DateFormatter.time(time) : "",
                  ),
                  label: "Waktu",
                  hintText: "Masukan waktu pembayaran",
                ),
              ],
              if (status == "paid") ...[
                verticalSpace(5),
                MultimediaButton(
                  path: widget.transaction?.url,
                  onTap: (e) {
                    file = e;
                  },
                  title: "Upload Bukti Pembayaran",
                  onCancel: () {
                    file = null;
                  },
                ),
              ],
              if (status != null) ...[
                verticalSpace(20),
                ValueListenableBuilder(
                  valueListenable: loading,
                  builder: (context, value, _) {
                    return PrimaryButton(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState!.validate()) {
                          Modals().confirmation(
                            onTap: () async {
                              Map<String, dynamic> request = {
                                "status": status,
                                "pivot_room_id": user?.pivot?.id ??
                                    widget.transaction?.pivotRoomId,
                                "price": priceController.text,
                                "date": DateTime(
                                  date!.year,
                                  date!.month,
                                  date!.day,
                                  time!.hour,
                                  time!.minute,
                                ),
                              };
                              loading.value = true;
                              if (file != null) {
                                request["photo"] =
                                    await MultipartFile.fromFile(file!.path);
                              }
                              bool res = false;
                              if (widget.transaction == null) {
                                res = await FinanceRepository.storeIncome(
                                    request);
                              } else {
                                res = await FinanceRepository.updateIncome(
                                  widget.transaction!.id!,
                                  request,
                                );
                              }
                              loading.value = false;
                              if (res) {
                                backScreen();
                              }
                            },
                          );
                        }
                      },
                      loading: loading.value,
                      label: "Submit",
                      radius: 8,
                      color: ColorAsset.violet,
                    );
                  },
                ),
                verticalSpace(10),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
