import 'package:image_picker/image_picker.dart';

class QuotationItem {
  late String? itemName;
  late int? quantity;
  late String? description;
  late String? unit;
  late List<String>? imageURLs = [];
  List<XFile>? imageFileList = [];

  QuotationItem({
    this.itemName,
    this.quantity,
    this.description,
    this.unit,
    this.imageFileList,
    this.imageURLs,
  });

  toJson() {
    return {
      "itemName": itemName,
      "quantity": quantity,
      "description": description,
      "unit": unit,
      'imageURLs': imageURLs!.map((i) => i).toList(),
    };
  }

  factory QuotationItem.fromMap(Map<String, dynamic> json) {
    List<String> imageURLs = [];
    if (json['imageURLs'] != null) {
      json['imageURLs'].forEach((content) {
        // String _myQuotationItem = QuotationItem.fromMap(content);
        imageURLs.add(content);
      });
    } else {
      imageURLs = [];
    }

    return QuotationItem(
      itemName: json['itemName'],
      quantity: json['quantity'],
      description: json['description'],
      unit: json['unit'],
      imageURLs: imageURLs,
    );
  }
}
