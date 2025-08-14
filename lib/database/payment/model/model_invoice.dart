class ModelInvoice {
  ModelInvoice({
    this.reference,
    this.merchantRef,
    this.paymentSelectionType,
    this.paymentMethod,
    this.paymentName,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.callbackUrl,
    this.returnUrl,
    this.amount,
    this.feeMerchant,
    this.feeCustomer,
    this.totalFee,
    this.amountReceived,
    this.payCode,
    this.payUrl,
    this.checkoutUrl,
    this.status,
    this.expiredTime,
    required this.orderItems,
    required this.instructions,
    this.qrString,
    this.qrUrl,
  });

  final String? reference;
  final String? merchantRef;
  final String? paymentSelectionType;
  final String? paymentMethod;
  final String? paymentName;
  final String? customerName;
  final String? customerEmail;
  final String? customerPhone;
  final String? callbackUrl;
  final String? returnUrl;
  final int? amount;
  final int? feeMerchant;
  final int? feeCustomer;
  final int? totalFee;
  final int? amountReceived;
  final String? payCode;
  final String? payUrl;
  final String? checkoutUrl;
  final String? status;
  final int? expiredTime;
  final List<OrderItem> orderItems;
  final List<Instruction> instructions;
  final String? qrString;
  final String? qrUrl;

  factory ModelInvoice.fromJson(Map<String, dynamic> json) {
    print(json);
    return ModelInvoice(
      reference: json['reference'],
      merchantRef: json['merchant_ref'],
      paymentSelectionType: json['payment_selection_type'],
      paymentMethod: json['payment_method'],
      paymentName: json['payment_name'],
      customerName: json['customer_name'],
      customerEmail: json['customer_email'],
      customerPhone: json['customer_phone'],
      callbackUrl: json['callback_url'],
      returnUrl: json['return_url'],
      amount: json['amount'],
      feeMerchant: json['fee_merchant'],
      feeCustomer: json['fee_customer'],
      totalFee: json['total_fee'],
      amountReceived: json['amount_received'],
      payCode: json['pay_code'],
      payUrl: json['pay_url'],
      checkoutUrl: json['checkout_url'],
      status: json['status'],
      expiredTime: json['expired_time'],
      orderItems: (json['order_items'] as List).map((item) => OrderItem.fromJson(item)).toList(),
      instructions: (json['instructions'] as List).map((item) => Instruction.fromJson(item)).toList(),
      qrString: json['qr_string'],
      qrUrl: json['qr_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reference': reference,
      'merchant_ref': merchantRef,
      'payment_selection_type': paymentSelectionType,
      'payment_method': paymentMethod,
      'payment_name': paymentName,
      'customer_name': customerName,
      'customer_email': customerEmail,
      'customer_phone': customerPhone,
      'callback_url': callbackUrl,
      'return_url': returnUrl,
      'amount': amount,
      'fee_merchant': feeMerchant,
      'fee_customer': feeCustomer,
      'total_fee': totalFee,
      'amount_received': amountReceived,
      'pay_code': payCode,
      'pay_url': payUrl,
      'checkout_url': checkoutUrl,
      'status': status,
      'expired_time': expiredTime,
      'order_items': orderItems.map((e) => e.toJson()).toList(),
      'instructions': instructions.map((e) => e.toJson()).toList(),
      'qr_string': qrString,
      'qr_url': qrUrl,
    };
  }
}

class OrderItem {
  final String? sku;
  final String? name;
  final int? price;
  final int? quantity;
  final int? subtotal;
  final String? productUrl;
  final String? imageUrl;

  OrderItem({
    this.sku,
    this.name,
    this.price,
    this.quantity,
    this.subtotal,
    this.productUrl,
    this.imageUrl,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      sku: json['sku'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      productUrl: json['product_url'],
      imageUrl: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sku': sku,
      'name': name,
      'price': price,
      'quantity': quantity,
      'subtotal': subtotal,
      'product_url': productUrl,
      'image_url': imageUrl,
    };
  }
}

class Instruction {
  final String title;
  final List<String> steps;

  Instruction({
    required this.title,
    required this.steps,
  });

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      title: json['title'],
      steps: List<String>.from(json['steps']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'steps': steps,
    };
  }
}
