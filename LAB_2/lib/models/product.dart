/// Un produs, asa cum apare pe carduri si pe ecranul de detaliu.
class Product {
  final String name;
  final double price;
  final String image;

  const Product({
    required this.name,
    required this.price,
    required this.image,
  });

  /// "$ 39.99" - formatul exact din design (spatiu dupa simbol).
  String get formattedPrice => '\$ ${price.toStringAsFixed(2)}';
}

/// O recenzie din sectiunea Reviews.
class Review {
  final String author;
  final String avatar;
  final String text;
  final String timeAgo;
  final int stars;

  const Review({
    required this.author,
    required this.avatar,
    required this.text,
    required this.timeAgo,
    this.stars = 5,
  });
}

/// O categorie din randul de sus al homepage-ului.
class Category {
  final String label;
  final String asset;

  const Category(this.label, this.asset);
}
