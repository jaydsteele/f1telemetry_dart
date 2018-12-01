import '../f1telemetry.dart';

class PacketContext {

  Map<Type, Packet> _packets = new Map<Type, Packet>();

  void register(Packet value) {
    _packets[value.runtimeType] = value;
  }

  Packet get(Type type) {
    return _packets[type];
  }
}