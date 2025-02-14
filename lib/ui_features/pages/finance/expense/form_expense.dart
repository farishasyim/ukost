import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ukost/app/models/expense/expense.dart';
import 'package:ukost/app/repositories/finance/finance_repository.dart';
import 'package:ukost/config/constraint.dart';
import 'package:ukost/config/date_picker.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/export.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/buttons/multiple_multimedia_button.dart';
import 'package:ukost/ui_features/components/buttons/primary_button.dart';
import 'package:ukost/ui_features/components/inputs/textfield_primary.dart';

class FormExpensePage extends StatefulWidget {
  const FormExpensePage({super.key, this.expense});
  final Expense? expense;

  @override
  State<FormExpensePage> createState() => _FormExpensePageState();
}

class _FormExpensePageState extends State<FormExpensePage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? date;
  DateTime? time;
  TextEditingController priceController = TextEditingController(),
      titleController = TextEditingController(),
      descriptionController = TextEditingController();
  List<File> files = [];
  List<String> existed = [];
  List<String> deleted = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.expense != null) {
      titleController.text = widget.expense?.title ?? "";
      descriptionController.text = widget.expense?.description ?? "";
      priceController.text = (widget.expense?.price ?? 0).toString();
      date = widget.expense?.createdAt;
      time = widget.expense?.createdAt;
      existed = widget.expense!.photos;
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
            title: const Text("Pengeluaran"),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            children: [
              TextFieldPrimary(
                controller: titleController,
                label: "Nama pembelian",
                hintText: "Masukan nama pembelian",
              ),
              TextFieldPrimary(
                controller: descriptionController,
                maxLines: null,
                label: "Deskripsi pembelian",
                hintText: "Masukan deskripsi pembelian",
              ),
              TextFieldPrimary(
                controller: priceController,
                label: "Harga",
                keyboardType: TextInputType.number,
                hintText: "Masukan harga kamar",
              ),
              TextFieldPrimary(
                controller: TextEditingController(
                  text: date != null ? DateFormatter.date(date) : "",
                ),
                readOnly: true,
                label: "Tanggal Pembelian",
                onTap: () async {
                  var date = await DatePicker.getDatePicker(
                      this.date?.toIso8601String());
                  if (date != null) {
                    setState(() {
                      this.date = date;
                    });
                  }
                },
                hintText: "Masukan tanggal pembelian",
              ),
              TextFieldPrimary(
                readOnly: true,
                onTap: () async {
                  var time = await DatePicker.getTimePicker(this.time);
                  if (time != null) {
                    setState(() {
                      this.time = DateTime(2020, 1, 1, time.hour, time.minute);
                    });
                  }
                },
                controller: TextEditingController(
                  text: time != null ? DateFormatter.time(time) : "",
                ),
                label: "Waktu",
                hintText: "Masukan waktu pembayaran",
              ),
              verticalSpace(5),
              MultipleMultimediaButton(
                path: "receipt",
                paths: existed,
                onDelete: (e) {
                  deleted.add(e);
                },
                onTap: (e) {
                  files = e;
                },
                title: "Upload Kwitansi",
              ),
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
                            loading.value = true;
                            Map<String, dynamic> request = {
                              "title": titleController.text,
                              "description": descriptionController.text,
                              "date": DateTime(
                                date!.year,
                                date!.month,
                                date!.day,
                                time!.hour,
                                time!.minute,
                              ),
                              "price": priceController.text,
                              "photos[]": [],
                            };
                            for (var row in files) {
                              request["photos[]"]
                                  .add(await MultipartFile.fromFile(row.path));
                            }
                            var res = false;
                            if (widget.expense == null) {
                              res =
                                  await FinanceRepository.storeExpense(request);
                            } else {
                              request["deleted[]"] = deleted;
                              res = await FinanceRepository.updateExpense(
                                  widget.expense!.id!, request);
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
            ],
          ),
        ),
      ),
    );
  }
}
