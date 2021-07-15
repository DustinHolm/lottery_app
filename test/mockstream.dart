import 'package:mockito/mockito.dart';

import 'package:lottery_app/models/lottery.dart';
import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';
import 'package:lottery_app/models/app_user.dart';

class Mockstream extends Mock implements Stream<Lottery> {}

void main() async {

  AppUser getSeller() => AppUser(id: "SellerId", name: "SellerName",);
  AppUser getWinner() => AppUser(id: "WinnerId", name: "WinnerName",);
  List<Lottery> lotteries =[];

  Category _category;
  Condition _con;
  CollectType _col;

  Lottery getBaseLottery(var name, var c, var i, var ct) => Lottery.withRandomId(
    name: name,
    description: "Description",
    image: null,
    condition: _con=Condition.values[c],
    category: _category=Category.values[i],
    shippingCost: 21,
    endingDate: DateTime.now(),
    ticketMap: {},
    seller: getSeller(),
    winner: null,
    collectType: _col=CollectType.values[ct],
  );

  for (var i=0;i<=8;i++){
    lotteries.add(getBaseLottery("Test"+i.toString(),i%5, i, i%3));
    lotteries.add(getBaseLottery("2Test"+i.toString(),i%5, i, i%3));
  }


  var stream = Mockstream();

  //die idee war meine alten 18 lotteries zu nutzen, einige bräuchten jedoch tickets

  when(stream.listen(any)).thenAnswer((Invocation invocation) {
    return Stream<List<Lottery>>.fromIterable(<List<Lottery>>lotteries).listen();
  });

  stream.listen((e) async => print(await e));
}