import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The base class for the various Packet classes that can be created from
/// F12018 telemetry data.
///
/// A general Packet consists of two components: the
/// PacketHeader and the ByteData object that houses the raw data for the Packet.
/// The Packet subclasses reference this generic data blob and provider getter
/// methods for pulling the information out of it.
class Packet {

  /// The PacketHeader which prefixes every Packet
  final PacketHeader header;

  /// The ByteData object referencing the body of the Packet data.
  final ByteData data;

  /// Build a Packet object from a PacketHeader
  Packet(PacketHeader header) :
    header = header,
    // note that the ByteData body is constructed from the section of the
    // PacketHeader's data after the header
    data = ByteData.view(header.data.buffer, PacketHeader.sizeInBytes,
      header.data.lengthInBytes - PacketHeader.sizeInBytes)
  {
    // no-op
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('Packet {}');
    return result.toString();
  }
}