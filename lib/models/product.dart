import 'package:objectbox/objectbox.dart';

@Entity()
class Product {
  @Id()
  int id;
  String name;
  int quantity;
  double price;

  Product({this.id = 0, required this.name, required this.quantity, required this.price});
}