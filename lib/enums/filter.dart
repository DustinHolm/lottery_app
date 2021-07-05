enum Filter {
  NO_FILTER,
  CONDITION_FILTER,
  COLLECT_TYPE_FILTER,
  SELLER_NAME_FILTER,
  TICKETS_LESS_THAN_FILTER,
  LEAST_BIDS_SORT,
  ENDING_SOONEST_SORT
}

extension ParseToString on Filter {
  String toFormattedString() {
    return this.toString().split('.').last.replaceAll("_", " ").toLowerCase();
  }
}
