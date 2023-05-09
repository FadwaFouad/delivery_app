import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  int id;
  String name;
  String restaurant;
  String image;
  double price;
  String type;
  String description;

  Food(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.type,
      required this.restaurant,
      required this.description});

  factory Food.fromFirestore(QueryDocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    // convert int value to double
    double dataPrice = data['price'] + 0.0;

    return Food(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      price: dataPrice,
      image: data['image'],
      restaurant: data['restaurant'],
      type: data['type'],
    );
  }
}
