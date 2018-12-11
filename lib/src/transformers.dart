import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:f1telemetry_dart/f1telemetry.dart';

/// Transform socket data from a [RawSocketEvent] to a [Datagram] stream
StreamTransformer<RawSocketEvent, Datagram> makeSocketDatagramTransformer(socket) {
  return new StreamTransformer<RawSocketEvent, Datagram>.fromHandlers(
    handleData: (RawSocketEvent value, sink) {
      sink.add(socket.receive());
    }
  );
}

/// Convert a Datagram to an F12018 packet stream
StreamTransformer<Datagram, Packet> makePacketTransformer(PacketContext packetContext) {
  return new StreamTransformer<Datagram, Packet>.fromHandlers(
    handleData: (Datagram datagram, sink) {
      if (datagram == null) return null;
      ByteData data = Uint8List.fromList(datagram.data).buffer.asByteData();
      PacketHeader header = new PacketHeader(data, packetContext);
      sink.add(header.getPacket());
    }
  );
}
