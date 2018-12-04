import 'dart:async';
import 'dart:io';

import 'package:f1telemetry_dart/f1telemetry.dart';

void main() async {
  print('Listens for F12018 Laptimes and prints them to the console:');
  printLapTimes();
}

void printLapTimes() async {
  double lastLapTime = 0;
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
          if (packet.runtimeType == PacketLapData) {
            PacketLapData packetLapData = packet as PacketLapData;
            final newLapTime = packetLapData[packet.header.playerCarIndex].lastLapTime;
            if (newLapTime != lastLapTime) {
              lastLapTime = newLapTime;
              print('Lap time = ${newLapTime}');
            }
          }
        }
      }
    });
}