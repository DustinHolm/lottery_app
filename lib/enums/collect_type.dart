enum CollectType { SELF_COLLECT, PACKET, PACKET_INLAND }

extension ParseToString on CollectType {
  String toFormattedString() {
    switch (this) {
      case CollectType.SELF_COLLECT:
        return 'Selbstabholung';
      case CollectType.PACKET:
        return 'Paket Inland';
      default:
        return 'Paket';
    }
  }
}
