class CustomerRequestModel {
  final String payeeName;
  final String typeCode;
  final String deliveryTypeCode;
  final String date;
  final String notes;
  final String status;
  final int id;
  final int customerId;

  CustomerRequestModel({
    required this.payeeName,
    required this.typeCode,
    required this.deliveryTypeCode,
    required this.date,
    required this.notes,
    required this.status,
    required this.id,
    required this.customerId,
  });

  factory CustomerRequestModel.fromJson(Map<String, dynamic> json) {
    return CustomerRequestModel(
      payeeName: json['payeeName'],
      typeCode: json['type']['code'],
      deliveryTypeCode: json['deliveryType']['code'],
      date: json['date'],
      notes: json['notes'],
      status:json['status']['code'],
      id: json['id'],
      customerId:json['customer']['id'],

    );
  }
}
