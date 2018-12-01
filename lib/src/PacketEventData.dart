
import 'dart:convert';
import '../f1telemetry.dart';

class PacketEventData extends Packet {

  static final AsciiCodec asciiCodec = new AsciiCodec();

  PacketEventData(PacketHeader header) : super(header);

  String get eventStringCode {
    List<int> bytes = [
      data.getUint8(0),
      data.getUint8(1),
      data.getUint8(2),
      data.getUint8(3)
    ];
    return asciiCodec.decode(bytes);
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketEventData {');
    result.writeln('  eventStringCode: ${this.eventStringCode}');
    result.writeln('}');
    return result.toString();
  }
}
