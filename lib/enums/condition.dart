enum Condition { NEW, LIKE_NEW, GOOD, OK, BAD }

extension ParseToString on Condition {
  String toFormattedString() {
    switch (this) {
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
  }
}
