import 'dart:typed_data';
import 'dart:math';
import 'package:f1telemetry_dart/f1telemetry.dart';

class PacketSessionData extends Packet {

  static const PRE_MARSHAL_ZONE_SIZE_IN_BYTES = 19;

  static const MAX_MARSHAL_ZONES = 21;

  List<MarshallZone> _marshalZones = new List<MarshallZone>();

  PacketSessionData(PacketHeader header) : super(header) {
    for (int i=0; i<MAX_MARSHAL_ZONES; i++) {
      int offset = PacketHeader.sizeInBytes + PRE_MARSHAL_ZONE_SIZE_IN_BYTES + MarshallZone.sizeInBytes * i;
      ByteData mzData = ByteData.view(header.data.buffer, offset, MarshallZone.sizeInBytes);
      _marshalZones.add(new MarshallZone(mzData));
    }
  }

  Weather get weather { return parseWeather(data.getUint8(0)); }

  int get trackTemperature { return data.getInt8(1); }

  int get airTemperature { return data.getInt8(2); }

  int get totalLaps { return data.getUint8(3); }

  int get trackLength { return data.getUint16(4, Endian.host); }

  int get sessionType { return data.getUint8(6); }

  int get trackId { return data.getInt8(7); } // TODO: enum

  int get era { return data.getUint8(8); } // TODO: enum

  int get sessionTimeLeft { return data.getUint16(9, Endian.host); }

  int get sessionDuration { return data.getUint16(11, Endian.host); }

  int get pitSpeedLimit { return data.getUint8(13); }

  int get gamePaused { return data.getUint8(14); }

  int get isSpectating { return data.getUint8(15); }

  int get spectatorCarIndex { return data.getUint8(16); }

  int get sliProNativeSupport { return data.getUint8(17); }

  int get numMarshalZones { return data.getUint8(18); }

  List<MarshallZone> get marshalZones { return _marshalZones; } // TODO: Don't use a list here - simply return the object dynamically by index

  int get safetyCarStatus { return data.getUint8(19+MarshallZone.sizeInBytes*MAX_MARSHAL_ZONES); } // TODO: enum

  int get networkGame { return data.getUint8(20+MarshallZone.sizeInBytes*MAX_MARSHAL_ZONES); }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketSessionData {');
    result.writeln('  weather: ${weather}');
    result.writeln('  trackTemperature: ${trackTemperature}');
    result.writeln('  airTemperature: ${airTemperature}');
    result.writeln('  totalLaps: ${totalLaps}');
    result.writeln('  trackLength: ${trackLength}');
    result.writeln('  sessionType: ${sessionType}');
    result.writeln('  trackId: ${trackId}');
    result.writeln('  era: ${era}');
    result.writeln('  sessionTimeLeft: ${sessionTimeLeft}');
    result.writeln('  sessionDuration: ${sessionDuration}');
    result.writeln('  pitSpeedLimit: ${pitSpeedLimit}');
    result.writeln('  gamePaused: ${gamePaused}');
    result.writeln('  isSpectating: ${isSpectating}');
    result.writeln('  spectatorCarIndex: ${spectatorCarIndex}');
    result.writeln('  sliProNativeSupport: ${sliProNativeSupport}');
    result.writeln('  numMarshalZones: ${numMarshalZones}');
    result.writeln('  marshalZones: {');
    for (int i=0; i<min(numMarshalZones, MAX_MARSHAL_ZONES); i++) {
      result.writeln('${marshalZones[i]}');
    }
    result.writeln('  }');
    result.writeln('  safetyCarStatus: ${safetyCarStatus}');
    result.writeln('  networkGame: ${networkGame}');
    result.writeln('}');
    return result.toString();
  }
}

class MarshallZone {

  static const sizeInBytes = 5;

  ByteData data;

  MarshallZone(this.data);

  double get zoneStart { return data.getFloat32(0, Endian.host); }

  int get zoneFlag { return data.getInt8(4); }

  String toString() {
    return '    MarshallZone { zoneStart: ${zoneStart}, zoneFlag: ${zoneFlag} }';
  }
}