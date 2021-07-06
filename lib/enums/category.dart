enum Category {
  ELECTRONICS,
  KITCHEN,
  APPLIANCES,
  FURNITURE,
  DECORATION,
  GARDEN,
  BOOKS,
  CLOTHES,
  OTHER,
}

extension ParseToString on Category {
  String toFormattedString() {
    switch (this) {
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
}