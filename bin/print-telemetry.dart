import 'dart:async';
import 'dart:io';

import 'package:f1telemetry_dart/f1telemetry.dart';

void main() async {
  print('Listens for F12018 Telemetry (for the player) and logs it to the console:');
  printTelemetry();
}

void printTelemetry() async {
  RawDatagramSocket.bind(InternetAddress.anyIPv4, 20777)
    .then((RawDatagramSocket socket) async {
      PacketContext packetContext = new PacketContext();
      StreamTransformer datagramTransformer = makeSocketDatagramTransformer(socket);
      StreamTransformer packetTransformer = makePacketTransformer(packetContext);
      Stream stream = socket
        .transform(datagramTransformer)
        .transform(packetTransformer);
      await for (var packet in stream) {
        if (packet != null) {
          if (packet.runtimeType == PacketCarTelemetryData) {
            PacketCarTelemetryData packetCarTelemetryData = packet;
            CarTelemetryData playerCarTelemetryData = packetCarTelemetryData.playerCarTelemetryData;
            print(playerCarTelemetryData);
          }
        }
      }
    });
}