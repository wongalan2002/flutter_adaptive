import '../models/quotation_item.dart';

class QuotationOrder{
  String? userId;
  String? quotationRequester;
  DateTime? submissionDate;
  List<QuotationItem>? quotationItems;

  QuotationOrder({
    this.userId,
    this.quotationRequester,
    this.submissionDate,
    this.quotationItems,
  });

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'quotationRequester': quotationRequester,
    'submissionDate': submissionDate,
    'quotationItems': quotationItems!.map((i) => i.toJson()).toList(),
  };

  factory QuotationOrder.fromMap(Map<String, dynamic> json) {
    List<QuotationItem> quotationItems = [];
    if (json['quotationItems'] != null) {
      json['quotationItems'].forEach((content) {
        QuotationItem _myQuotationItem = QuotationItem.fromMap(content);
        quotationItems.add(_myQuotationItem);
      });
    } else {
      quotationItems = [];
    }

    return QuotationOrder(
      userId: json['userId'],
      quotationRequester: json['quotationRequester'],
      submissionDate: json['submissionDate'].toDate() ?? 'unknown',
      quotationItems: quotationItems,
    );
  }
}
