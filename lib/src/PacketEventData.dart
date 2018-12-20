import 'dart:convert';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The Packet wrapper for event data in the F12018 telemetry stream.
class PacketEventData extends Packet {

  // Codec for converting bytes to ascii chars
  static final AsciiCodec _asciiCodec = new AsciiCodec();

  PacketEventData(PacketHeader header) : super(header);

  /// The event string code
  ///
  /// | Event | Code | Description |
  /// | --- | --- | --- |
  /// | Session started | "SSTA" | Sent when the session starts |
  /// | Session ended | "SEND" | Sent when the session ends |
  String get eventStringCode {
    List<int> bytes = [
      data.getUint8(0),
      data.getUint8(1),
      data.getUint8(2),
      data.getUint8(3)
    ];
    return _asciiCodec.decode(bytes);
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('${PacketEventData} {');
    result.writeln('  eventStringCode: ${this.eventStringCode}');
    result.writeln('}');
    return result.toString();
  }
}
