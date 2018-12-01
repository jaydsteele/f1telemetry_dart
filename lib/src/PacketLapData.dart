import 'dart:typed_data';
import '../f1telemetry.dart';

class PacketLapData extends Packet {

  List<LapData> _lapData = new List<LapData>();

  PacketLapData(PacketHeader header) : super(header) {
    final PacketParticipantsData participantData = header.context.get(PacketParticipantsData);
    final numCars = (participantData != null) ? participantData.numCars : 0;
    for (int i=0; i<numCars; i++) {
      int offset = PacketHeader.sizeInBytes + LapData.sizeInBytes * i;
      ByteData subData = ByteData.view(header.data.buffer, offset, LapData.sizeInBytes);
      _lapData.add(new LapData(subData));
    }
  }

  List<LapData> get lapData { return _lapData; }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.write(this.header);
    result.writeln('PacketLapData {');
    result.writeln('  LapData {');
    for (int i=0; i<_lapData.length; i++) {
      result.write('${lapData[i]}');
    }
    result.writeln('  }');
    result.writeln('}');
    return result.toString();
  }
}

class LapData {

  static const sizeInBytes = 41;

  ByteData data;

  LapData(this.data);

  double get lastLapTime { return data.getFloat32(0, Endian.host); }

  double get currentLapTime { return data.getFloat32(4, Endian.host); }

  double get bestLapTime { return data.getFloat32(8, Endian.host); }

  double get sector1Time { return data.getFloat32(12, Endian.host); }

  double get sector2Time { return data.getFloat32(16, Endian.host); }

  double get lapDistance { return data.getFloat32(20, Endian.host); }

  double get totalDistance { return data.getFloat32(24, Endian.host); }

  double get safetyCarDelta { return data.getFloat32(28, Endian.host); }

  int get carPosition { return data.getUint8(32); }

  int get currentLapNum { return data.getUint8(33); }

  int get pitStatus { return data.getUint8(34); }

  int get sector { return data.getUint8(35); }

  int get currentLapInvalid { return data.getUint8(36); }

  int get penalties { return data.getUint8(37); }

  int get gridPosition { return data.getUint8(38); }

  int get driverStatus { return data.getUint8(39); }

  int get resultStatus { return data.getUint8(40); }

  String toString() {
    StringBuffer result = new StringBuffer();
    result.writeln('    LapData {');
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
