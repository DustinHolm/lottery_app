enum Filter {
  NO_FILTER,
  TITLE_FILTER,
  CATEGORY_FILTER,
  CONDITION_FILTER,
  COLLECT_TYPE_FILTER,
  SELLER_NAME_FILTER,
  TICKETS_LESS_THAN_FILTER,
  LEAST_BIDS_SORT,
  ENDING_SOONEST_SORT
}

extension ParseToString on Filter {
  String toFormattedString() {
    switch (this) {
      case Filter.NO_FILTER:
        return "Zurücksetzen";
      case Filter.TITLE_FILTER:
        return "Suche";
      case Filter.CATEGORY_FILTER:
        return "Kategorie auswählen";
      case Filter.CONDITION_FILTER:
        return "Zustand auswählen";
      case Filter.COLLECT_TYPE_FILTER:
        return "Versandart auswählen";
      case Filter.SELLER_NAME_FILTER:
        return "Verkäufer angeben";
      case Filter.TICKETS_LESS_THAN_FILTER:
        return "Maximale Anzahl Tickets";
      case Filter.LEAST_BIDS_SORT:
        return "Wenigste Gebote";
      case Filter.ENDING_SOONEST_SORT:
        return "Bald endende Angebote";
    }
  }
}
