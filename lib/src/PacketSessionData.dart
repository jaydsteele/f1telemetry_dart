import 'dart:typed_data';
import 'dart:math';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The [Packet] container for information about the current session.
class PacketSessionData extends Packet {

  // The number of bytes preceeding the array of marshall zones
  static const _preMarshalZoneSizeInBytes = 19;

  // The maximum number of marshall zones
  static const _maxMarshallZones = 21;

  // The pre-constructed list of marshall zone objects
  List<MarshallZone> _marshalZones = new List<MarshallZone>();

  PacketSessionData(PacketHeader header) : super(header) {
    for (int i=0; i<_maxMarshallZones; i++) {
      int offset = PacketHeader.sizeInBytes + _preMarshalZoneSizeInBytes + MarshallZone.sizeInBytes * i;
      ByteData mzData = ByteData.view(header.data.buffer, offset, MarshallZone.sizeInBytes);
      _marshalZones.add(new MarshallZone(mzData));
    }
  }

  /// Weather
  ///
  /// See [Weather]
  int get weather => data.getUint8(0);

  /// Track temp. in degrees celsius
  int get trackTemperature => data.getInt8(1);

  /// Air temp. in degrees celsius
  int get airTemperature => data.getInt8(2);

  /// Total number of laps in this race
  int get totalLaps => data.getUint8(3);

  /// Track length in metres
  int get trackLength => data.getUint16(4, Endian.host);

  /// The session type
  ///
  /// See [SessionType]
  int get sessionType => data.getUint8(6);

  /// The track ID
  ///
  /// -1 for unknown, 0-21 for tracks
  int get trackId => data.getInt8(7);

  /// The racing era
  ///
  /// 0 = modern, 1 = classic
  int get era => data.getUint8(8); // TODO: enum

  /// Time left in session in seconds
  int get sessionTimeLeft => data.getUint16(9, Endian.host);

  /// Session duration in seconds
  int get sessionDuration => data.getUint16(11, Endian.host);

  /// Pit speed limit in kilometres per hour
  int get pitSpeedLimit => data.getUint8(13);

  /// Whether the game is paused
  int get gamePaused => data.getUint8(14);

  /// Whether the player is spectating
  int get isSpectating => data.getUint8(15);

  /// Index of the car being spectated
  int get spectatorCarIndex => data.getUint8(16);

  /// SLI Pro support, 0 = inactive, 1 = active
  int get sliProNativeSupport => data.getUint8(17);

  /// Number of marshal zones to follow
  int get numMarshalZones => data.getUint8(18);

  /// List of marshal zones – max 21
  List<MarshallZone> get marshalZones => _marshalZones; // TODO: Don't use a list here - simply return the object dynamically by index

  /// Status of the safety car
  ///
  /// 0 = no safety car, 1 = full safety car
  /// 2 = virtual safety car
  int get safetyCarStatus => data.getUint8(19+MarshallZone.sizeInBytes*_maxMarshallZones); // TODO: enum

  /// Network game status
  ///
  /// 0 = offline, 1 = online
  int get networkGame => data.getUint8(20+MarshallZone.sizeInBytes*_maxMarshallZones);

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
    for (int i=0; i<min(numMarshalZones, _maxMarshallZones); i++) {
      result.writeln('${marshalZones[i]}');
    }
    result.writeln('  }');
    result.writeln('  safetyCarStatus: ${safetyCarStatus}');
    result.writeln('  networkGame: ${networkGame}');
    result.writeln('}');
    return result.toString();
  }
}

/// The object wrapper for a marshall zone
class MarshallZone {

  /// The size of the data for object in bytes
  static const sizeInBytes = 5;

  /// The [ByteData] object for this object
  ByteData data;

  MarshallZone(this.data);

  /// Fraction (0..1) of way through the lap the marshal zone starts
  double get zoneStart => data.getFloat32(0, Endian.host);

  // -1 = invalid/unknown, 0 = none, 1 = green, 2 = blue, 3 = yellow, 4 = red
  int get zoneFlag => data.getInt8(4);

  String toString() {
    return '    MarshallZone { zoneStart: ${zoneStart}, zoneFlag: ${zoneFlag} }';
  }
}