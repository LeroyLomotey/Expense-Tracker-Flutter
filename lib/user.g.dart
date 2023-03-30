// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 1;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      name: fields[0] as String,
      balance: fields[1] as double,
      darkMode: fields[5] as bool,
      notify: fields[6] as bool,
      currency: fields[3] as String,
    )..transactions = (fields[4] as List).cast<Transaction>();
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.balance)
      ..writeByte(3)
      ..write(obj.currency)
      ..writeByte(4)
      ..write(obj.transactions)
      ..writeByte(5)
      ..write(obj.darkMode)
      ..writeByte(6)
      ..write(obj.notify);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
