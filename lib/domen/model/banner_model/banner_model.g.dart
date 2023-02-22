// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BannerModelAdapter extends TypeAdapter<BannerModel> {
  @override
  final int typeId = 1;

  @override
  BannerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BannerModel(
      image: fields[0] as String,
      product: fields[1] as ProductModel,
    );
  }

  @override
  void write(BinaryWriter writer, BannerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BannerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
