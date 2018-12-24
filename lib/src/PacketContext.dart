import 'package:f1telemetry_dart/f1telemetry.dart';

/// Stores a reference to the previous received Packet of the specified type.
///
/// As packets are streaming in, it is convenient to store the last received
/// edition of each packet type so it can be easily accessed a stream listener.
/// It prevents the implementor from needing to listen to every incoming packet
/// type. Instead, they can listen for the primary packet type they need and look
/// up other types via the context when needed.
class PacketContext {

  // The dictionary of packets for each packet type
  Map<Type, Packet> _packets = new Map<Type, Packet>();

  /// Register the packet instance [value] in the context.
  void register(Packet value) {
    _packets[value.runtimeType] = value;
  }

  /// Get the [Packet] instance of the specified [type] last stored the context.
  Packet get(Type type) {
    return _packets[type];
  }

  /// clear the context
  void clear() {
    _packets.clear();
  }
}