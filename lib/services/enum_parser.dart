import 'package:lottery_app/enums/category.dart';
import 'package:lottery_app/enums/collect_type.dart';
import 'package:lottery_app/enums/condition.dart';

class EnumParser {
  static String? parse(Object value) {
    if (value.runtimeType == Condition) {
      switch (value) {
        case Condition.NEW:
          return "Neu";
        case Condition.LIKE_NEW:
          return "Wie neu";
        case Condition.GOOD:
          return "Ganz gut";
        case Condition.OK:
          return "Akzeptabel";
        case Condition.BAD:
          return "Schlecht";
      }
    } else if (value.runtimeType == CollectType) {
      switch (value) {
        case CollectType.SELF_COLLECT:
          return 'Nur Selbstabholung';
        case CollectType.PACKET:
          return 'Lieferung möglich';
        case CollectType.PACKET_INLAND:
          return 'Lieferung möglich (Inland)';
      }
    } else if (value.runtimeType == Category) {
      switch (value) {
        case Category.ELECTRONICS:
          return 'Elektroartikel';
        case Category.KITCHEN:
          return 'Küchenzubehör';
        case Category.APPLIANCES:
          return 'Haushaltsgeräte';
        case Category.FURNITURE:
          return 'Möbel';
        case Category.DECORATION:
          return 'Dekoration';
        case Category.GARDEN:
          return 'Garten';
        case Category.BOOKS:
          return 'Bücher';
        case Category.CLOTHES:
          return 'Kleidung';
        default:
          return 'Sonstiges';
      }
    }
    return null;
  }
}