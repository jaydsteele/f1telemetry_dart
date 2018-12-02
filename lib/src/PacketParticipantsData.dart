import 'dart:typed_data';
import 'dart:convert';
import 'package:f1telemetry_dart/f1telemetry.dart';

class PacketParticipantsData extends Packet {

  static const prefixSizeInBytes = 1;

  PacketParticipantsData(PacketHeader header) : super(header);

  int get numCars { return data.getUint8(0); }

  ParticipantData operator [](int index) {
    ByteData data = ByteData.view(
      header.data.buffer,
      PacketHeader.sizeInBytes + prefixSizeInBytes + ParticipantData.sizeInBytes * index,
      ParticipantData.sizeInBytes
    );
    return new ParticipantData(data);
  }

  int get length {
    return numCars;
  }

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

class ParticipantData {

  static final Utf8Codec utf8codec = new Utf8Codec();

  static const sizeInBytes = 53;

  ByteData data;

  String _name;

  ParticipantData(this.data);

  int get aiControlled { return data.getUint8(0); }

  int get driverId { return data.getUint8(1); } // TODO: enum

  int get teamId { return data.getUint8(2); } // TODO: enum

  int get raceNumber { return data.getUint8(3); }

  int get nationality { return data.getUint8(4); } // TODO: enum

  String get name {
    if (_name == null) {
      // TODO: Try to do this a better way, using raw views - for some reason
      // I could only get this working like this.
      List<int> chars = new List<int>();
      for (int i=0; i<48; i++) {
        if (data.getUint8(i+5) == 0) break;
        chars.add(data.getUint8(i+5));
      }
      _name = utf8codec.decode(chars);
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