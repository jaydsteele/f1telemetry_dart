import 'dart:convert';
import 'dart:typed_data';
import '../f1telemetry.dart';

class Packet {

  static final JsonCodec jsonCodec = new JsonCodec();

  final PacketHeader header;

  final data;

  Packet(PacketHeader header) :
    header = header,
    data = ByteData.view(header.data.buffer, PacketHeader.sizeInBytes, header.data.lengthInBytes - PacketHeader.sizeInBytes) {}

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('Packet {}');
    return result.toString();
  }
}