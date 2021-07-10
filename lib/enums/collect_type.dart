enum CollectType { SELF_COLLECT, PACKET, PACKET_INLAND }

extension ParseToString on CollectType {
  String toFormattedString() {
    switch (this) {
      case CollectType.SELF_COLLECT:
        return 'Nur Selbstabholung';
      case CollectType.PACKET:
        return 'Lieferung möglich';
      default:
        return 'Lieferung möglich (Inland)';
    }
  }
}
