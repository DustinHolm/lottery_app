enum CollectType { SELF_COLLECT, PACKET, PACKET_INLAND }

extension ParseToString on CollectType {
  String toFormattedString() {
    return this.toString().split('.').last.replaceAll("_", " ").toLowerCase();
  }
}
