// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'propertyModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PropertyModelAdapter extends TypeAdapter<PropertyModel> {
  @override
  final int typeId = 1;

  @override
  PropertyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PropertyModel(
      username: fields[0] as String?,
      usernumber: fields[1] as String?,
      timestamp: fields[2] as Timestamp?,
      action: fields[3] as String?,
      docId: fields[4] as String?,
      currentUserId: fields[5] as String?,
      propertyType: fields[6] as String?,
      propertyFor: fields[7] as String?,
      city: fields[8] as String?,
      area: fields[9] as String?,
      address: fields[10] as String?,
      size: fields[11] as String?,
      bedrooms: fields[12] as String?,
      bathrooms: fields[13] as String?,
      kitchen: fields[14] as String?,
      descr: fields[15] as String?,
      price: fields[16] as String?,
      images: (fields[17] as List?)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, PropertyModel obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.usernumber)
      ..writeByte(2)
      ..write(obj.timestamp)
      ..writeByte(3)
      ..write(obj.action)
      ..writeByte(4)
      ..write(obj.docId)
      ..writeByte(5)
      ..write(obj.currentUserId)
      ..writeByte(6)
      ..write(obj.propertyType)
      ..writeByte(7)
      ..write(obj.propertyFor)
      ..writeByte(8)
      ..write(obj.city)
      ..writeByte(9)
      ..write(obj.area)
      ..writeByte(10)
      ..write(obj.address)
      ..writeByte(11)
      ..write(obj.size)
      ..writeByte(12)
      ..write(obj.bedrooms)
      ..writeByte(13)
      ..write(obj.bathrooms)
      ..writeByte(14)
      ..write(obj.kitchen)
      ..writeByte(15)
      ..write(obj.descr)
      ..writeByte(16)
      ..write(obj.price)
      ..writeByte(17)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PropertyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
