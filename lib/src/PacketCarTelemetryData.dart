import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// A [Packet] of data representing car telemetry for all cars on track.
class PacketCarTelemetryData extends Packet {

  /// Construct from a [header] that represents this object.
  PacketCarTelemetryData(PacketHeader header) : super(header);

  /// Get the [CarTelemetryData] at the specified index
  CarTelemetryData operator [](int index) {
    ByteData data = ByteData.view(
      header.data.buffer,
      PacketHeader.sizeInBytes + CarTelemetryData.sizeInBytes * index,
      CarTelemetryData.sizeInBytes
    );
    return new CarTelemetryData(data);
  }

  /// The number of cars with [CarTelemetryData]
  int get length {
    PacketParticipantsData packetParticipantsData = header.context.get(PacketParticipantsData);
    return packetParticipantsData?.numCars ?? 0;
  }

  /// Bit flags specifying which buttons are being pressed currently
  ///
  /// | Bit Flag | Button Description |
  /// | ---      | ---                |
  /// | 0x0001   | Cross or A         |
  /// | 0x0002   | Triangle or Y      |
  /// | 0x0004   | Circle or B        |
  /// | 0x0008   | Square or X        |
  /// | 0x0010   | D-pad left         |
  /// | 0x0020   | D-pad right        |
  /// | 0x0040   | D-pad up           |
  /// | 0x0080   | D-pad down         |
  /// | 0x0100   | Options or menu    |
  /// | 0x0200   | L1 or LB           |
  /// | 0x0400   | R1 or RB           |
  /// | 0x0800   | L2 or LT           |
  /// | 0x1000   | R2 or RT           |
  /// | 0x2000   | Left stick click   |
  /// | 0x4000   | Right stick click  |
  int get buttonStatus {
    return data.getUint32(CarTelemetryData.sizeInBytes * 20);
  }

  // The [CarTelemetryData] object for the player's car
  CarTelemetryData get playerCarTelemetryData {
    return this[header.playerCarIndex];
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketCarTelemetryData {');
    result.writeln('  CarTelemetryData {');
    int numCars = this.length;
    for (int i=0; i<numCars; i++) {
      result.writeln('    ${this[i]}');
    }
    result.writeln('  }');
    result.writeln('}');
    return result.toString();
  }
}

/// The data view that wraps car telemetry data for a single car on track.
class CarTelemetryData {

  /// The size of this object in bytes in the ByteData blob
  static const int sizeInBytes = 53;

  /// The ByteData blob housing the data for this object
  ByteData data;

  /// Construct this object from a [ByteData] object.
  CarTelemetryData(this.data);

  /// Speed of car in kilometres per hour
  int get speed => data.getUint16(0, Endian.host);

  /// Amount of throttle applied (0 to 100)
  int get throttle => data.getUint8(2);

  /// Steering: -100 (full lock left) to 100 (full lock right)
  int get steer => data.getInt8(3);

  /// Amount of brake applied (0 to 100)
  int get brake => data.getInt8(4);

  /// Amount of clutch applied (0 to 100)
  int get clutch => data.getUint8(5);

  /// Gear selected (1-8, N=0, R=-1
  int get gear => data.getInt8(6);

  /// Engine RPM
  int get engineRPM => data.getUint16(7);

  /// 0 = off, 1 = on
  int get drs => data.getUint8(9);

  /// Rev lights indicator (percentage)
  int get revLightsPercent => data.getUint8(10);

  /// Brakes temperature (celsius)
  List<int> get brakesTemperature {
    // TODO: Implement
    throw new Exception('Not yet supported');
  }

  /// Tyres surface temperature (celsius)
  List<int> get tyresSurfaceTemperature {
    // TODO: Implement
    throw new Exception('Not yet supported');
  }

  /// Tyres inner temperature (celsius)
  List<int> get tyresInnerTemperature {
    // TODO: Implement
    throw new Exception('Not yet supported');
  }

  /// Engine temperature (celsius)
  int get engineTemperature {
    // TODO: Implement
    throw new Exception('Not yet supported');
  }

  /// Tyres pressure (PSI)
  List<double> get tyresPressure {
    // TODO: Implement
    throw new Exception('Not yet supported');
  }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.writeln('  ${CarTelemetryData} {');
    result.writeln('    speed: ${speed}');
    result.writeln('    throttle: ${throttle}');
    result.writeln('    steer: ${steer}');
    result.writeln('    brake: ${brake}');
    result.writeln('    clutch: ${clutch}');
    result.writeln('    gear: ${gear}');
    result.writeln('    engineRPM: ${engineRPM}');
    result.writeln('    drs: ${drs}');
    result.writeln('    revLightsPercent: ${revLightsPercent}');
    result.writeln('  }');
    return result.toString();
  }
}