import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

class PacketCarTelemetryData extends Packet {

  PacketCarTelemetryData(PacketHeader header) : super(header);

  CarTelemetryData operator [](int index) {
    ByteData data = ByteData.view(
      header.data.buffer,
      PacketHeader.sizeInBytes + CarTelemetryData.sizeInBytes * index,
      CarTelemetryData.sizeInBytes
    );
    return new CarTelemetryData(data);
  }

  int get length {
    PacketParticipantsData packetParticipantsData = header.context.get(PacketParticipantsData);
    return packetParticipantsData?.numCars ?? 0;
  }

  int get buttonStatus {
    return data.getUint32(CarTelemetryData.sizeInBytes * 20);
  }

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

class CarTelemetryData {
  static const int sizeInBytes = 53;
  ByteData data;

  CarTelemetryData(this.data);

  int get speed { return data.getUint16(0, Endian.host); }

  int get throttle { return data.getUint8(2); }

  int get steer { return data.getInt8(3); }

  int get brake { return data.getInt8(4); }

  int get clutch { return data.getUint8(5); }

  int get gear { return data.getInt8(6); }

  int get engineRPM { return data.getUint16(7); }

  int get drs { return data.getUint8(9); }

  int get revLightsPercent { return data.getUint8(10); }

  List<int> get brakesTemperature {
    throw new Exception('Not yet supported');
  }

  List<int> get tyresSurfaceTemperature {
    throw new Exception('Not yet supported');
  }

  List<int> get tyresInnerTemperature {
    throw new Exception('Not yet supported');
  }
  List<int> get engineTemperature {
    throw new Exception('Not yet supported');
  }

  List<double> get tyresPressure {
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