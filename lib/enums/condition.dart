enum Condition { NEW, LIKE_NEW, GOOD, OK, BAD }

extension ParseToString on Condition {
  String toFormattedString() {
    return this.toString().split('.').last.replaceAll("_", " ").toLowerCase();
  }
}
