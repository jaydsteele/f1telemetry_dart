import 'dart:typed_data';
import 'dart:convert';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The [Packet] container for participant data for all cars on track.
class PacketParticipantsData extends Packet {

  // The number of bytes preceeding the start of the array of participants
  static const _prefixSizeInBytes = 1;

  PacketParticipantsData(PacketHeader header) : super(header);

  /// The number of cars
  int get numCars => data.getUint8(0);

  /// Get the [ParticipantData] object for car at the specified index
  ParticipantData operator [](int index) {
    ByteData data = ByteData.view(
      header.data.buffer,
      PacketHeader.sizeInBytes + _prefixSizeInBytes + ParticipantData.sizeInBytes * index,
      ParticipantData.sizeInBytes
    );
    return new ParticipantData(data);
  }

  /// The number of cars (alias for numCars)
  int get length => numCars;

  /// The the [ParticipantData] object for the player's car
  ParticipantData get playerParticipantData {
    return this[header.playerCarIndex];
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketParticipantsData {');
    result.writeln('  numCars: ${numCars}');
    result.writeln('  Participants {');
    for (int i=0; i<numCars; i++) {
      result.write('${this[i]}');
    }
    result.writeln('  }');
    result.writeln('}');
    return result.toString();
  }
}

/// The wrapper around a block of [ByteData] representing the data
/// for a single race participant.
class ParticipantData {

  // For generating a string from UTF-8 encoded bytes
  static final Utf8Codec _utf8codec = new Utf8Codec();

  /// The size of this object in bytes
  static const sizeInBytes = 53;

  /// The raw data representing this object
  ByteData data;

  // The converted name from utf8 bytes
  String _name;

  ParticipantData(this.data);

  /// Whether the vehicle is AI (1) or Human (0) controlled
  int get aiControlled => data.getUint8(0);

  /// Driver id
  int get driverId => data.getUint8(1); // TODO: enum

  /// Team id
  int get teamId => data.getUint8(2); // TODO: enum

  /// Race number of the car
  int get raceNumber => data.getUint8(3);

  /// Nationality of the driver
  int get nationality => data.getUint8(4); // TODO: enum

  /// Name of participant.
  ///
  /// Will be truncated with … (U+2026) if too long
  String get name {
    if (_name == null) {
      // TODO: Try to do this a better way, using raw views - for some reason
      // I could only get this working like this.
      List<int> chars = new List<int>();
      for (int i=0; i<48; i++) {
        if (data.getUint8(i+5) == 0) break;
        chars.add(data.getUint8(i+5));
      }
      _name = _utf8codec.decode(chars);
    }
    return _name;
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.writeln('    ParticipantData {');
    result.writeln('      aiControlled: ${aiControlled}');
    result.writeln('      driverId: ${driverId}');
    result.writeln('      teamId: ${teamId}');
    result.writeln('      raceNumber: ${raceNumber}');
    result.writeln('      nationality: ${nationality}');
    result.writeln('      name: ${name}');
    result.writeln('    }');
    return result.toString();
  }
}