import 'package:flutter/material.dart';
import 'package:ukost/app/models/complain/complain.dart';
import 'package:ukost/app/repositories/complain/complain_repository.dart';
import 'package:ukost/config/color_assets.dart';
import 'package:ukost/config/dialog.dart';
import 'package:ukost/config/format_date.dart';
import 'package:ukost/config/navigation_services.dart';
import 'package:ukost/ui_features/components/horizontal/horizontal_text.dart';
import 'package:ukost/ui_features/components/tile/finance_tile.dart';
import 'package:ukost/ui_features/pages/complain/form_complain_page.dart';

class ComplaintPage extends StatefulWidget {
  const ComplaintPage({super.key});

  @override
  State<ComplaintPage> createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  List<Complain> complains = [];
  int? selected;

  Future<void> init() async {
    complains = await ComplainRepository.getComplains();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    init().ignore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Komplain"),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: "expense",
        onPressed: () {
          nextScreen(const FormComplainPage());
        },
        backgroundColor: ColorAsset.violet,
        child: Icon(
          Icons.add_rounded,
          color: ColorAsset.white,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await init();
        },
        child: ListView(
          children: [
            for (var row in complains)
              FinanceTile(
                title: row.title,
                trailing: Icon(
                  row.adminId != null ? Icons.check_box : Icons.close,
                  color:
                      row.adminId != null ? ColorAsset.success : ColorAsset.red,
                ),
                subtitle: DateFormatter.dateTime(row.createdAt),
                onTap: () {
                  setState(() {
                    if (selected == row.id) {
                      selected = null;
                    } else {
                      selected = row.id;
                    }
                  });
                },
                onLongPress: () {
                  Modals().action(
                    onDelete: () {
                      Modals().confirmation(
                        onTap: () async {
                          var res =
                              await ComplainRepository.deleteComplain(row.id!);
                          if (res) {
                            init();
                          }
                        },
                      );
                    },
                    onEdit: () {
                      nextScreen(FormComplainPage(complain: row));
                    },
                  );
                },
                expanded: selected == row.id,
                children: [
                  HorizontalText(
                    title: row.description,
                  ),
                  if (row.urls.isNotEmpty)
                    HorizontalText(
                      title: "",
                      trailing: "Lampiran",
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (e) {
                            return PageView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (var row in row.urls) Image.network(row),
                              ],
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
