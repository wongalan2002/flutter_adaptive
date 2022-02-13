import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/quotation_item.dart';
import '../models/quotation_order.dart';
import 'package:adaptive_app_demos/application_state.dart';
import '../global/styling.dart';
import 'quotation_order_sent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class QuotationOrderConfirmPage extends StatefulWidget {
  QuotationOrder quotationOrder;
  bool history = false;
  QuotationOrderConfirmPage(
      {Key? key, required this.quotationOrder, required this.history})
      : super(key: key);
  @override
  _QuotationOrderConfirmPageState createState() => _QuotationOrderConfirmPageState();
}

class _QuotationOrderConfirmPageState extends State<QuotationOrderConfirmPage> {
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  @override
  void initState() {
    super.initState();
    imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<ApplicationState>(context);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        title: Text(
          (() {
            if (widget.history) {
              return '過去報價';
            } else {
              return '確定報價';
            }
          })(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
                      child: Text(
                        '${widget.quotationOrder.quotationRequester}',
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                      child: Text(
                        "${widget.quotationOrder.submissionDate?.year.toString()}-"
                            "${widget.quotationOrder.submissionDate?.month.toString().padLeft(2, '0')}-"
                            "${widget.quotationOrder.submissionDate?.day.toString().padLeft(2, '0')}  "
                            "${widget.quotationOrder.submissionDate?.hour.toString().padLeft(2, '0')}:"
                            "${widget.quotationOrder.submissionDate?.minute.toString().padLeft(2, '0')}",
                      ),
                    ),
                    Expanded(
                      // child: SingleChildScrollView(
                      //   physics: BouncingScrollPhysics(),
                      //   scrollDirection: Axis.vertical,
                      //   child: buildDataTable(),
                      // ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: buildDataTable(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible:
                      widget.quotationOrder.quotationItems!.isNotEmpty &&
                          widget.history == false,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            80, 30, 80, 16),
                        child: ElevatedButton(
                          child: const SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            primary: activeBackgroundColor,
                            elevation: 0,
                            shadowColor: Colors.transparent,
                          ),
                          onPressed: () {
                            setState(() {
                              uploading = true;
                            });
                            widget.quotationOrder.userId =
                                FirebaseAuth.instance.currentUser!.uid;
                            // widget.quotationOrder.userId =
                            //     appState.userProfile.id!;
                            uploadFile()
                                .whenComplete(() => appState.addQuotationOrder(
                                widget.quotationOrder.toJson()))
                            // .whenComplete(() => Navigator.of(context)
                            //   ..pop()
                            //   ..pop());
                                .whenComplete(() => Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) =>
                                const QuotationOrderSent())));
                            print(
                                'Button NEXT ... ${widget.quotationOrder.toJson()}');
                          },
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
          uploading
              ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'uploading...',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CircularProgressIndicator(
                    value: val,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.green),
                  )
                ],
              ))
              : Container(),
        ],
      ),
    );
  }

  Widget buildDataTable() {
    return DataTable(
      showCheckboxColumn: false,
      columns: [
        DataColumn(
          label: Text("項目 (${widget.quotationOrder.quotationItems!.length})"),
          numeric: false,
        ),
        const DataColumn(
          label: Text("數量"),
          numeric: true,
        ),
        const DataColumn(
          label: Text("附加資料"),
          numeric: false,
        ),
      ],
      rows: getRows(context, widget.quotationOrder.quotationItems!),
    );
  }

  List<DataRow> getRows(
      BuildContext context, List<QuotationItem> quotationItems) {
    List<DataRow> dataRows = [];
    for (int i = 0; i < quotationItems.length; i++) {
      String? itemName = quotationItems[i].itemName;
      int? quantity = quotationItems[i].quantity;
      String? description = quotationItems[i].description;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(itemName!)),
          DataCell(Text('$quantity')),
          DataCell(Text(description!)),
        ],
      );
      dataRows.add(row);
    }
    return dataRows;
  }

  Future uploadFile() async {
    int i = 1;
    num totalNumberImg = 0;
    for (var item in widget.quotationOrder.quotationItems!) {
      totalNumberImg = totalNumberImg + item.imageFileList!.length;
    }
    for (var item in widget.quotationOrder.quotationItems!) {
      List<String> _imageURLs = [];
      for (var img in item.imageFileList!) {
        setState(() {
          val = i / totalNumberImg;
        });
        ref = firebase_storage.FirebaseStorage.instance
            .ref()
            .child('images/${Path.basename(img.path)}');
        if (kIsWeb) {
          await ref.putData(await img.readAsBytes()).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              _imageURLs.add(value);
              i++;
            });
          });
        } else {
          await ref.putFile(File(img.path)).whenComplete(() async {
            await ref.getDownloadURL().then((value) {
              _imageURLs.add(value);
              i++;
            });
          });
        }
      }
      item.imageURLs = _imageURLs;
    }
  }
}
