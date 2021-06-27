import 'package:lottery_app/enums/payment_type.dart';
import 'package:lottery_app/filter/transform.dart';
import 'package:lottery_app/models/lottery.dart';

class PaymentTypeFilter implements ITransform {
  PaymentType _paymentType;

  PaymentTypeFilter(PaymentType paymentType) : _paymentType = paymentType;

  @override
  Iterable<Lottery> transformLotteries(Iterable<Lottery> lotteries) {
    return lotteries.where((lottery) => lottery.paymentType == _paymentType);
  }
}
