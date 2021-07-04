enum PaymentType { PAYPAL, BANKWIRE, CREDIT_CARD }

extension ParseToString on PaymentType {
  String toFormattedString() {
    return this.toString().split('.').last.replaceAll("_", " ").toLowerCase();
  }
}
