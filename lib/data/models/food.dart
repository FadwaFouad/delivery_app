import 'package:cloud_firestore/cloud_firestore.dart';

class Food {
  String name;
  String restaurant;
  String image;
  double price;
  String type;
  String description;

  Food(
      {required this.name,
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
      name: data['name'],
      description: data['description'],
      price: dataPrice,
      image: data['image'],
      restaurant: data['restaurant'],
      type: data['type'],
    );
  }
}
