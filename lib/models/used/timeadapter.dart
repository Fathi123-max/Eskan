import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';

class TimestampAdapter extends TypeAdapter<Timestamp> {
  @override
  int get typeId =>
      100; // Unique ID for the adapter (you can choose any positive integer).

  @override
  Timestamp read(BinaryReader reader) {
    // Read the timestamp as a long value and create a Timestamp object.
    return Timestamp(reader.readInt32(), reader.readInt32());
  }

  @override
  void write(BinaryWriter writer, Timestamp obj) {
    // Write the timestamp as a long value (seconds) and an integer (nanoseconds).
    writer.writeInt32(obj.seconds);
    writer.writeInt32(obj.nanoseconds);
  }
}
