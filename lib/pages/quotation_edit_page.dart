import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/quotation_item.dart';
import '../global/styling.dart';

class QuotationEditPage extends StatefulWidget {
  QuotationEditPage(
      {Key? key,
      this.callback,
      this.quotationItem,
      this.quotationItemIndex,
      required this.isEdit,
      this.restorationId})
      : super(key: key);
  Function? callback;
  QuotationItem? quotationItem;
  int? quotationItemIndex;
  final bool isEdit;
  final String? restorationId;

  @override
  _QuotationEditPageState createState() => _QuotationEditPageState();
}

class _QuotationEditPageState extends State<QuotationEditPage> {
  bool detailVisible = false;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  late TextEditingController itemTextController =
  TextEditingController();
  late TextEditingController qtyTextController =
  TextEditingController();
  late TextEditingController unitTextController =
  TextEditingController();
  late TextEditingController descriptionTextController =
  TextEditingController();

  // late RestorableTextEditingController itemTextController =
  //     RestorableTextEditingController();
  // late RestorableTextEditingController qtyTextController =
  //     RestorableTextEditingController();
  // late RestorableTextEditingController unitTextController =
  //     RestorableTextEditingController();
  // late RestorableTextEditingController descriptionTextController =
  //     RestorableTextEditingController();

  final imageMaxLimit = 3;
  List<XFile>? _imageFileList;

  set _imageFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }
  final _picker = ImagePicker();
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      detailVisible = true;
    } else {
      detailVisible = false;
    }
  }

  @override
  void dispose() {
    itemTextController.dispose();
    qtyTextController.dispose();
    unitTextController.dispose();
    descriptionTextController.dispose();
    super.dispose();
  }

  void didChangeDependencies() {
    widget.quotationItem?.itemName != null
        ? itemTextController.text = widget.quotationItem!.itemName!
        : itemTextController.text = "";
    widget.quotationItem?.quantity != null
        ? qtyTextController.text = widget.quotationItem!.quantity!.toString()
        : qtyTextController.text = "";
    widget.quotationItem?.unit != null
        ? unitTextController.text = widget.quotationItem!.unit!
        : unitTextController.text = "";
    widget.quotationItem?.description != null
        ? descriptionTextController.text = widget.quotationItem!.description!
        : descriptionTextController.text = "";
    widget.quotationItem?.imageFileList != null
        ? _imageFileList = widget.quotationItem?.imageFileList!
        : _imageFileList = [];
    // widget.quotationItem?.itemName != null
    //     ? itemTextController.value.text = widget.quotationItem!.itemName!
    //     : itemTextController.value.text = "";
    // widget.quotationItem?.quantity != null
    //     ? qtyTextController.value.text = widget.quotationItem!.quantity!.toString()
    //     : qtyTextController.value.text = "";
    // widget.quotationItem?.unit != null
    //     ? unitTextController.value.text = widget.quotationItem!.unit!
    //     : unitTextController.value.text = "";
    // widget.quotationItem?.description != null
    //     ? descriptionTextController.value.text = widget.quotationItem!.description!
    //     : descriptionTextController.value.text = "";
    // widget.quotationItem?.imageFileList != null
    //     ? _imageFileList = widget.quotationItem?.imageFileList!
    //     : _imageFileList = [];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: textColor),
        backgroundColor: backgroundColor,
        automaticallyImplyLeading: true,
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.isEdit
              ? localizations.quotaItemTitleEdit
              : localizations.quotaItemTitleNew,
          style: EasyQuoteTextStyles.h5,
        ),
        actions: [
          if (widget.isEdit) ...[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text('Delete "${widget.quotationItem?.itemName}"'),
                  content: const Text('This item will be permanently deleted'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                          ..pop()
                          ..pop();
                        widget.callback!(
                            widget.quotationItemIndex,
                            QuotationItem(
                              itemName: itemTextController.value.text,
                              quantity: int.parse(qtyTextController.value.text),
                              description: descriptionTextController.value.text,
                            ),
                            true);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 0, 15, 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                  child: Text(
                    localizations.quotaItemText,
                    style: EasyQuoteTextStyles.subtitle,
                  ),
                ),
                TextFormField(
                  // controller: itemTextController.value,
                  controller: itemTextController,
                  decoration: formInputDecoration.copyWith(
                      hintText: localizations.quotaItemTextHint),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return localizations.quotaItemTextV;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                  child: Text(
                    localizations.quotaItemQuantity,
                    style: EasyQuoteTextStyles.subtitle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          flex: 2,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            // controller: qtyTextController.value,
                            controller: qtyTextController,
                            decoration: formInputDecoration.copyWith(
                                hintText: localizations.quotaItemQuantityHint),
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some number';
                              }
                              if (int.parse(qtyTextController.value.text) >
                                  99999999999) {
                                return 'You have reached maximum number';
                              }
                              if (int.parse(qtyTextController.value.text) <= 0) {
                                return 'Quantity must be larger than zero';
                              }
                              return null;
                            },
                          ),
                        ),
                        Visibility(
                          visible: detailVisible,
                          child: const SizedBox(
                            width: 20.0,
                          ),
                        ),
                        Visibility(
                            visible: detailVisible,
                            child: Flexible(
                              child: TextFormField(
                                // controller: unitTextController.value,
                                controller: unitTextController,
                                decoration: formInputDecoration.copyWith(
                                    hintText: localizations.quotaItemUnit),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                  child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              localizations.quotaItemAdditional,
                              style: EasyQuoteTextStyles.subtitle,
                            ),
                            Switch(
                              value: detailVisible,
                              onChanged: (value) {
                                setState(() {
                                  detailVisible = value;
                                });
                              },
                              activeTrackColor: Colors.deepPurple,
                              activeColor: Colors.deepPurpleAccent,
                            ),
                          ])),
                ),
                Visibility(
                  visible: detailVisible,
                  child: SizedBox(
                    height: 200,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: 7,
                      // controller: descriptionTextController.value,
                      controller: descriptionTextController,
                      decoration: formInputDecoration.copyWith(
                          hintText: localizations.quotaItemDescriptionHint),
                    ),
                  ),
                ),
                Visibility(
                  visible: detailVisible,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 10),
                    child: Text(
                      '${localizations.quotaItemImage} ${_imageFileList?.length}/$imageMaxLimit',
                      style: EasyQuoteTextStyles.subtitle,
                    ),
                  ),
                ),
                Visibility(
                  visible: detailVisible,
                  child: SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _imageFileList!.length + 1,
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Center(
                                  child: Ink(
                                      decoration: const ShapeDecoration(
                                          shape: CircleBorder(),
                                          color: activeBackgroundColor),
                                      height: 100,
                                      width: 60,
                                      child: IconButton(
                                          icon: const Icon(Icons.photo),
                                          color: Colors.white,
                                          onPressed: () {
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                            if (_imageFileList!.length <
                                                    imageMaxLimit &&
                                                !uploading) {
                                              _showPicker(context);
                                            }
                                          })),
                                )
                              : SizedBox(
                                  width: 100,
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(0, 0),
                                        child: kIsWeb
                                            ? Container(
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: NetworkImage(
                                                      _imageFileList![index - 1]
                                                          .path),
                                                  fit: BoxFit.cover,
                                                )),
                                              )
                                            : Container(
                                                margin: const EdgeInsets.all(3),
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                  image: FileImage(File(
                                                      _imageFileList![index - 1]
                                                          .path)),
                                                  fit: BoxFit.cover,
                                                )),
                                              ),
                                      ),
                                      Align(
                                          alignment:
                                              const AlignmentDirectional(1, -1),
                                          child: ElevatedButton(
                                            child: const Icon(
                                              Icons.delete,
                                              size: 15,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                shape: const CircleBorder(),
                                                padding:
                                                    const EdgeInsets.all(0),
                                                primary: buttonColor),
                                            onPressed: () {
                                              setState(() {
                                                _imageFileList!
                                                    .removeAt(index - 1);
                                              });
                                              print(index);
                                            },
                                          )),
                                    ],
                                  ),
                                );
                        }),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                  child: ElevatedButton(
                    child: SizedBox(
                      height: 56,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          widget.isEdit
                              ? localizations.quotaItemButtonUpdate
                              : localizations.quotaItemButtonAdd,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      primary: buttonColor,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      if (widget.isEdit == true) {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context);
                          widget.callback!(
                              widget.quotationItemIndex,
                              QuotationItem(
                                itemName: itemTextController.value.text,
                                quantity: int.parse(qtyTextController.value.text),
                                description: descriptionTextController.value.text,
                                unit: unitTextController.value.text,
                                imageFileList: _imageFileList,
                              ),
                              false);
                        }
                      } else {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pop();
                          widget.callback!(QuotationItem(
                              itemName: itemTextController.value.text,
                              quantity: int.parse(qtyTextController.value.text),
                              description: descriptionTextController.value.text,
                              unit: unitTextController.value.text,
                              imageFileList: _imageFileList,
                              imageURLs: []));
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      // chooseImage();
                      chooseImageGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    // chooseImage();
                    chooseImageCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  chooseImageCamera() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      _imageFileList?.add(pickedFile!);
    });
    if (pickedFile?.path == null) retrieveLostData();
  }

  chooseImageGallery() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _imageFileList?.add(pickedFile!);
    });
    if (pickedFile?.path == null) retrieveLostData();
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        // _imageFile = response.file;
        _imageFileList = response.files;
        // _image.add(response.file));
      });
    } else {
      print(response.file);
    }
  }

  // @override
  // String? get restorationId => widget.restorationId;
  //
  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(itemTextController, 'item');
  //   registerForRestoration(qtyTextController, 'qty');
  //   registerForRestoration(unitTextController, 'unit');
  //   registerForRestoration(descriptionTextController, 'description');
  // }
}
