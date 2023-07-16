import 'package:haider/models/used/propertyModel.dart';
import 'package:hive/hive.dart';

class PropertyModelAdapter extends TypeAdapter<PropertyModel> {
  @override
  final int typeId = 0;

  @override
  PropertyModel read(BinaryReader reader) {
    final propertyModel = PropertyModel()
      ..username = reader.read()
      ..usernumber = reader.read()
      ..timestamp = reader.read()
      ..action = reader.read()
      ..docId = reader.read()
      ..currentUserId = reader.read()
      ..propertyType = reader.read()
      ..propertyFor = reader.read()
      ..city = reader.read()
      ..area = reader.read()
      ..address = reader.read()
      ..size = reader.read()
      ..bedrooms = reader.read()
      ..bathrooms = reader.read()
      ..kitchen = reader.read()
      ..descr = reader.read()
      ..price = reader.read()
      ..images = reader.readList();
    return propertyModel;
  }

  @override
  void write(BinaryWriter writer, PropertyModel propertyModel) {
    writer
      ..write(propertyModel.username)
      ..write(propertyModel.usernumber)
      ..write(propertyModel.timestamp)
      ..write(propertyModel.action)
      ..write(propertyModel.docId)
      ..write(propertyModel.currentUserId)
      ..write(propertyModel.propertyType)
      ..write(propertyModel.propertyFor)
      ..write(propertyModel.city)
      ..write(propertyModel.area)
      ..write(propertyModel.address)
      ..write(propertyModel.size)
      ..write(propertyModel.bedrooms)
      ..write(propertyModel.bathrooms)
      ..write(propertyModel.kitchen)
      ..write(propertyModel.descr)
      ..write(propertyModel.price)
      ..writeList(propertyModel.images!);
  }
}
