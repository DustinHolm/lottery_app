enum Filter {
  NO_FILTER,
  TITLE_FILTER,
  SELLER_NAME_FILTER,
  TICKETS_LESS_THAN_FILTER,
  CATEGORY_FILTER,
  CONDITION_FILTER,
  COLLECT_TYPE_FILTER,
  ENDING_SOONEST_SORT,
  LEAST_BIDS_SORT,
  MOST_BIDS_SORT
}

extension ParseToString on Filter {
  String toFormattedString() {
    switch (this) {
      case Filter.NO_FILTER:
        return "Zurücksetzen";
      case Filter.TITLE_FILTER:
        return "Suche";
      case Filter.CATEGORY_FILTER:
        return "Kategorie";
      case Filter.CONDITION_FILTER:
        return "Zustand";
      case Filter.COLLECT_TYPE_FILTER:
        return "Versandart";
      case Filter.SELLER_NAME_FILTER:
        return "Verkäufer";
      case Filter.TICKETS_LESS_THAN_FILTER:
        return "Max Tickets";
      case Filter.LEAST_BIDS_SORT:
        return "Niedrigste Gebote";
      case Filter.MOST_BIDS_SORT:
        return "Höchste Gebote";
      case Filter.ENDING_SOONEST_SORT:
        return "Bald endend";
    }
  }
}
