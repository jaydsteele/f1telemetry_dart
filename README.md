# f1telemetry_dart
A dart library for gathering telemetry from the F12018 video game from CodeMasters.

## Background

F12018 is a Formula 1 racing video game by CodeMasters that broadcasts a generous
amount of game state and telemetry information via UDP. The Codemasters crew were
kind enough to publish the specification for this UDP specification, which you can find online on their forums [here](https://forums.codemasters.com/discussion/136948/f1-2018-udp-specification)

## What Does This Library Do?

f1telemetry_dart is a dart implementation of a library that can process these UDP broadcasts. It does all of the low-level bit/byte parsing, and provides nicer APIs.

The bigger objective is to use the library to create mobile apps using Google's Flutter environment. I thought that open-sourcing the low level data APIs would be a nice thing to do for the racing/software community, and also allow us to take advantage of all those great open-source community benefits like helping us fix bugs and make the library better.

## How It Works

I wanted to keep the library as efficient as possible, and avoid creating too many temporary objects. After all, the UDP packets can stream in at 30-50 fps.

Whenever possible, I use the original data blobs (given to us as ByteData objects) from the UDP stream. I try to reference into those blobs using subviews when accessing and converting the data. There are a few cases where duplicate information is created (for example when we decode UTF-8 bytes) but these cases are minimized. Suggestions on how to improve this are welcome.

I also use Dart stream transformers to make it easy to simply plug into the raw UDP stream and process packets. The APIs make the assumption that the stream broadcast packets contain whole telemetry "Packets", and they don't need to be reassembled in any way. This makes it really easy for us to parse, but also means streaming the telemetry from a firehose (like a file) wouldn't work.

## Example

The following Dart snippet uses the library to print lap times to the console. A functioning version of this script can be found in the bin directory.

The library provides two StreamTransformers to help:

1. makeSocketDatagramTransformer creates a really simple StreamTransformer that simply converts the Datagram socket events to their corresponding Datagram objects.
1. makePacketTransformer creates a transformer that sniffs these Datagrams and constructs the appropriate F12018 Telemetry objects.

```dart
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

```

## Some things you can do:

First, change to the project directory:

```bash
% cd f1telemetry_dart
```

Generate documentation:
```bash
% dartdoc
```

Run the laptimes script:
```bash
% pub run print-telemetry.dart
```

