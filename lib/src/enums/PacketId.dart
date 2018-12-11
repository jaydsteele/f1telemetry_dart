/// The packetId of a PacketHeader
enum PacketId {
  Motion, Session, Lap, Event, Participants, CarSetups, CarTelemetry, CarStatus
}

/// Parse a packet id value and convert it to a PacketId enum value
PacketId parsePacketId(int value) {
  switch(value) {
    case 0: return PacketId.Motion;
    case 1: return PacketId.Session;
    case 2: return PacketId.Lap;
    case 3: return PacketId.Event;
    case 4: return PacketId.Participants;
    case 5: return PacketId.CarSetups;
    case 6: return PacketId.CarTelemetry;
    case 7: return PacketId.CarStatus;
    default:
      throw new Exception('Unknown PacketId: ${value}');
  }
}