import 'package:hive/hive.dart';

class CartItemModel extends HiveObject {
  final String username;
  final int id;
  final String name;
  final String released;
  final int rating;
  final String image_url;
  int quantity;

  CartItemModel({
    required this.username,
    required this.id,
    required this.name,
    required this.released,
    required this.rating,
    required this. image_url,
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
      id: fields[1] as int,
      name: fields[2] as String,
      released: fields[3] as String,
      rating: fields[5] as int,
      image_url: fields[6] as String,
      quantity: fields[7] as int,
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
      ..writeByte(5)
      ..write(obj.rating);
  }
}
