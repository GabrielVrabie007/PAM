import '../models/product.dart';

/// Continut hardcodat, preluat literal din frame-urile Figma
/// "homepage full" (2:164) si "product full" (2:426).
abstract final class DemoData {
  static const String imgPath = 'assets/images';

  // --- Homepage: Feature Products (4 carduri, ultimul taiat de margine) ---
  static const featured = <Product>[
    Product(name: 'Turtleneck Sweater', price: 39.99, image: '$imgPath/feat_turtleneck_sweater.png'),
    Product(name: 'Long Sleeve Dress', price: 45.00, image: '$imgPath/feat_long_sleeve_dress.png'),
    Product(name: 'Sportwear Set', price: 80.00, image: '$imgPath/feat_sportwear_set.png'),
    Product(name: 'Elegant Dress', price: 75.00, image: '$imgPath/feat_elegant_dress.png'),
  ];

  // --- Homepage: Recommended ---
  static const recommended = <Product>[
    Product(name: 'White fashion hoodie', price: 29.00, image: '$imgPath/rec_white_hoodie.png'),
    Product(name: 'Cotton T-shirt', price: 30.00, image: '$imgPath/rec_cotton_tshirt.png'),
  ];

  // --- Ecranul de produs ---
  static const product = Product(
    name: 'Sportwear Set',
    price: 80.00,
    image: '$imgPath/product_sportwear_set.png',
  );

  static const description =
      'Sportswear is no longer under culture, it is no longer indie or '
      'cobbled together as it once was. Sport is fashion today. The top is '
      'oversized in fit and style, may need to size down.';

  static const rating = 4.9;
  static const ratingsCount = 83;
  static const reviewsCount = 47;

  /// Latimea barei umplute din Figma, raportata la track-ul de 234px,
  /// impreuna cu procentul afisat in dreapta.
  static const ratingBreakdown = <({int stars, double fill, String label})>[
    (stars: 5, fill: 198 / 234, label: '80%'),
    (stars: 4, fill: 46 / 234, label: '12%'),
    (stars: 3, fill: 21 / 234, label: '5%'),
    (stars: 2, fill: 14 / 234, label: '3%'),
    (stars: 1, fill: 0, label: '0%'),
  ];

  static const reviews = <Review>[
    Review(
      author: 'Jennifer Rose',
      avatar: '$imgPath/avatar_jennifer_rose.png',
      text: 'I love it.  Awesome customer service!! Helped me out with adding '
          'an additional item to my order. Thanks again!',
      timeAgo: '5m ago',
    ),
    Review(
      author: 'Kelly Rihana',
      avatar: '$imgPath/avatar_kelly_rihana.png',
      text: "I'm very happy with order, It was delivered on and good quality. "
          'Recommended!',
      timeAgo: '9m ago',
    ),
  ];

  static const similar = <Product>[
    Product(name: 'Rise Crop Hoodie', price: 43.00, image: '$imgPath/similar_rise_crop_hoodie.png'),
    Product(name: 'Gym Crop Top', price: 39.99, image: '$imgPath/similar_gym_crop_top.png'),
    Product(name: 'Sport Sweatshirt', price: 47.99, image: '$imgPath/similar_sport_sweatshirt.png'),
  ];
}
