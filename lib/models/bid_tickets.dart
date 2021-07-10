class BidTickets {
  BidTickets({required this.ticketMap});

  String? nextWinner;
  Map<String, int> ticketMap;

  int getTicketsUsed() {
    if (ticketMap.isNotEmpty) {
      return ticketMap.values.reduce((a, b) => a + b);
    } else {
      return 0;
    }
  }

  Map<String, dynamic> toJson() => {
    "nextWinner": nextWinner,
    "ticketMap": ticketMap
  };

  BidTickets.fromJson(Map<String, dynamic> json)
      : nextWinner = json["nextWinner"],
        ticketMap = Map<String, int>.from(json["ticketMap"]);
}
