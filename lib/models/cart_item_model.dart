import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class CartItemModel extends HiveObject {
  @HiveField(0)
  final String username;

  @HiveField(1)
  final String id; 

  @HiveField(2)
  final String name;

  @HiveField(3)
  final String released;

  @HiveField(4)
  final double rating;

  @HiveField(5)
  final String image_url;

  @HiveField(6)
  int quantity;

  CartItemModel({
    required this.username,
    required this.id,
    required this.name,
    required this.released,
    required this.rating,
    required this.image_url,
    required this.quantity,
  });
}

class CartItemAdapter extends TypeAdapter<CartItemModel> {
  @override
  final int typeId = 1;

  @override
  CartItemModel read(BinaryReader reader) {
    final fields = <int, dynamic>{};
    final fieldCount = reader.readByte();
    for (var i = 0; i < fieldCount; i++) {
      fields[reader.readByte()] = reader.read();
    }

    return CartItemModel(
      username: fields[0] as String,
      id: fields[1]?.toString() ?? '', 
      name: fields[2] as String,
      released: fields[3] as String,
      rating: (fields[4] as num).toDouble(),
      image_url: fields[5] as String,
      quantity: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CartItemModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.released)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.image_url)
      ..writeByte(6)
      ..write(obj.quantity);
  }
}