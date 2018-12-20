import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The header that prefixes every [Packet] in an F12018 telemetry stream.
class PacketHeader {

  /// The number of bytes used by a Packet object in the data stream
  static const sizeInBytes = 21;

  /// The ByteData wrapper used to reference the data
  ByteData data;

  /// A reference to the PacketContext object, which provides access to the
  /// last received Packets of different types.
  PacketContext context;

  /// Construct a PacketHeader object with a data object and context.
  PacketHeader(this.data, this.context);

  /// The [Packet] format identifier (e.g. 2018 for F12018)
  int get packetFormat => data.getUint16(0, Endian.host);

  /// The [Packet] version number
  int get packetVersion => data.getUint8(2);

  /// The id for this [Packet]
  int get packetId => data.getUint8(3);

  /// The UID for the session
  int get sessionUID => data.getUint64(4, Endian.host);

  /// The session time, in seconds
  double get sessionTime => data.getFloat32(12, Endian.host);

  /// The frame identifier
  int get frameIdentifier => data.getUint32(16, Endian.host);

  /// The index of the player car in player car lists (e.g. [PacketParticipantsData]
  /// and [PacketCarTelemetryData])
  int get playerCarIndex => data.getUint8(20);

  /// Create the [Packet] object that this [PacketHeader] represents.
  Packet getPacket() {
    Packet result = null;
    switch(this.packetId) {
      case PacketId.event:
        result = new PacketEventData(this);
        break;
      case PacketId.session:
        result = new PacketSessionData(this);
        break;
      case PacketId.participants:
        result = new PacketParticipantsData(this);
        break;
      case PacketId.lap:
        result = new PacketLapData(this);
        break;
      case PacketId.carTelemetry:
        result = new PacketCarTelemetryData(this);
        break;
      default:
        result = new Packet(this);
        break;
    }
    context.register(result);
    return result;
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.writeln('${PacketHeader} {');
    result.writeln('  packetFormat: ${this.packetFormat}');
    result.writeln('  packetVersion: ${this.packetVersion}');
    result.writeln('  packetId: ${this.packetId}');
    result.writeln('  sessionUID: ${this.sessionUID}');
    result.writeln('  sessionTime: ${this.sessionTime}');
    result.writeln('  playerCarIndex: ${this.playerCarIndex}');
    result.writeln('}');
    return result.toString();
  }
}
