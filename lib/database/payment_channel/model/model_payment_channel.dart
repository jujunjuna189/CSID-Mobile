class ModelPaymentChannel {
  ModelPaymentChannel({
    this.group,
    this.code,
    this.name,
    this.type,
    this.feeMerchant,
    this.feeCustomer,
    this.totalFee,
    this.iconUrl,
  });

  final String? group;
  final String? code;
  final String? name;
  final String? type;
  final Fee? feeMerchant;
  final Fee? feeCustomer;
  final Fee? totalFee;
  final String? iconUrl;

  factory ModelPaymentChannel.fromJson(Map<String, dynamic> json) {
    return ModelPaymentChannel(
      group: json["group"] ?? '',
      code: json["code"] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? "",
      feeMerchant:
          Fee(flat: (json['fee_merchant']['flat'] ?? 0), percent: (json['fee_merchant']['percent'] ?? 0).toString()),
      feeCustomer:
          Fee(flat: (json['fee_customer']['flat'] ?? 0), percent: (json['fee_customer']['percent'] ?? 0).toString()),
      totalFee: Fee(flat: (json['total_fee']['flat'] ?? 0), percent: (json['total_fee']['percent'] ?? 0).toString()),
      iconUrl: json['icon_url'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "group": group,
        "code": code,
        "name": name,
        "type": type,
        "fee_merchant": feeMerchant,
        "fee_customer": feeCustomer,
        "total_fee": totalFee,
        "icon_url": iconUrl,
      };
}

class Fee {
  Fee({this.flat, this.percent});

  final int? flat;
  final String? percent;
}
