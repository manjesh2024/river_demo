import 'package:hive/hive.dart';

import '../model/local_contact.dart';

class LocalContactAdapter extends TypeAdapter<LocalContact> {
  @override
  final int typeId = 0;

  @override
  LocalContact read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalContact(
      name: fields[0] as String,
      phone: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalContact obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.phone);
  }
}
