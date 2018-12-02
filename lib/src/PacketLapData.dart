import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// The Packet container for Lap Data, a snapshot of Lap information for all
/// cars on track.
class PacketLapData extends Packet {

  /// Build a Packet from the PacketHeader
  PacketLapData(PacketHeader header) : super(header);

  /// Retrieve the LapData object for the car at the specific index
  LapData operator [](int index) {
    ByteData data = ByteData.view(
      header.data.buffer,
      PacketHeader.sizeInBytes + LapData.sizeInBytes * index,
      LapData.sizeInBytes
    );
    return new LapData(data);
  }

  /// The number of LapData objects (the number of cars on track)
  int get length {
    PacketParticipantsData packetParticipantsData = header.context.get(PacketParticipantsData);
    return packetParticipantsData?.numCars ?? 0;
  }

  /// Get the LapData object for the player
  LapData get playerLapData {
    return this[header.playerCarIndex];
  }

  // Get a String representation of this PacketLapData object.
  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketLapData {');
    result.writeln('  LapData {');
    int numCars = this.length;
    for (int i=0; i<numCars; i++) {
      result.writeln('    ${this[i]}');
    }
    result.writeln('  }');
    result.writeln('}');
    return result.toString();
  }
}

/// The LapData information for a single car. This is a data view wraping a ByteData
/// object, which is the raw bytes producted by the telemetry data stream. It provides
/// a number of convenience functions to access the underlying information from the
/// data stream.
class LapData {

  /// The number of bytes required to represent a single LapData record in
  /// the raw telemetry data.
  static const sizeInBytes = 41;

  /// The raw byte blob representing this LapData object.
  ByteData data;

  /// Construct a LapData object from a ByteData data object.
  LapData(this.data);

  /// Last lap time in seconds
  double get lastLapTime { return data.getFloat32(0, Endian.host); }

  /// Current time around the lap in seconds
  double get currentLapTime { return data.getFloat32(4, Endian.host); }

  /// Best lap time of the session in seconds
  double get bestLapTime { return data.getFloat32(8, Endian.host); }

  /// Sector 1 time in seconds
  double get sector1Time { return data.getFloat32(12, Endian.host); }

  /// Sector 2 time in seconds
  double get sector2Time { return data.getFloat32(16, Endian.host); }

  /// Distance vehicle is around current lap in metres – could
  /// be negative if line hasn’t been crossed yet
  double get lapDistance { return data.getFloat32(20, Endian.host); }

  /// Total distance travelled in session in metres – could
  /// be negative if line hasn’t been crossed yet
  double get totalDistance { return data.getFloat32(24, Endian.host); }

  /// Delta in seconds for safety car
  double get safetyCarDelta { return data.getFloat32(28, Endian.host); }

  /// Car race position
  int get carPosition { return data.getUint8(32); }

  /// Current lap number
  int get currentLapNum { return data.getUint8(33); }

  /// The pit status
  int get pitStatus { return data.getUint8(34); }

  /// The current sector
  int get sector { return data.getUint8(35); }

  /// Whether the current lap is invalid
  bool get currentLapInvalid { return data.getUint8(36) == 1; }

  /// Accumulated time penalties in seconds to be added
  int get penalties { return data.getUint8(37); }

  /// Grid position the vehicle started the race in
  int get gridPosition { return data.getUint8(38); }

  /// Status of driver
  // TODO: enum
  int get driverStatus { return data.getUint8(39); }

  /// Result status
  // TODO: enum
  int get resultStatus { return data.getUint8(40); }

  // String reprentation
  String toString() {
    StringBuffer result = new StringBuffer();
    result.writeln('    ${LapData} {');
    result.writeln('      lastLapTime: ${lastLapTime}');
    result.writeln('      currentLapTime: ${currentLapTime}');
    result.writeln('      bestLapTime: ${bestLapTime}');
    result.writeln('      sector1Time: ${sector1Time}');
    result.writeln('      sector2Time: ${sector2Time}');
    result.writeln('      lapDistance: ${lapDistance}');
    result.writeln('      totalDistance: ${totalDistance}');
    result.writeln('      safetyCarDelta: ${safetyCarDelta}');
    result.writeln('      carPosition: ${carPosition}');
    result.writeln('      currentLapNum: ${currentLapNum}');
    result.writeln('      pitStatus: ${pitStatus}');
    result.writeln('      sector: ${sector}');
    result.writeln('      currentLapInvalid: ${currentLapInvalid}');
    result.writeln('      penalties: ${penalties}');
    result.writeln('      gridPosition: ${gridPosition}');
    result.writeln('      driverStatus: ${driverStatus}');
    result.writeln('      resultStatus: ${resultStatus}');
    result.writeln('    }');
    return result.toString();
  }
}
