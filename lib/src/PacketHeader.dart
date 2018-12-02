import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

class PacketHeader {

  static const sizeInBytes = 21;
  ByteData data;
  PacketContext context;

  PacketHeader(this.data, this.context);

  int get packetFormat { return data.getUint16(0, Endian.host); }

  int get packetVersion { return data.getUint8(2); }

  PacketId get packetId { return parsePacketId(data.getUint8(3)); }

  int get sessionUID { return data.getUint64(4, Endian.host); }

  double get sessionTime { return data.getFloat32(12, Endian.host); }

  int get frameIdentifier { return data.getUint32(16, Endian.host); }

  int get playerCarIndex { return data.getUint8(20); }

  Packet getPacket() {
    Packet result = null;
    switch(this.packetId) {
      case PacketId.Event:
        result = new PacketEventData(this);
        break;
      case PacketId.Session:
        result = new PacketSessionData(this);
        break;
      case PacketId.Participants:
        result = new PacketParticipantsData(this);
        break;
      case PacketId.Lap:
        result = new PacketLapData(this);
        break;
      case PacketId.CarTelemetry:
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
    result.writeln('PacketHeader {');
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
