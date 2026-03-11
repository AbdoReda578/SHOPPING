import 'package:flutter/foundation.dart';
import '../models/product.dart';

class ShopProvider with ChangeNotifier {
  static const double vatRate = 0.14;

  List<Product> products = [
    const Product(
      id: 'p1',
      title: 'كاميرا احترافية',
      price: '23000',
      imageUrl: 'https://picsum.photos/seed/p1/400/300',
      description: 'كاميرا بدقة عالية مناسبة للتصوير.',
    ),
    const Product(
      id: 'p2',
      title: 'لابتوب 14 بوصة',
      price: '44500',
      imageUrl: 'https://picsum.photos/seed/p2/400/300',
      description: 'لابتوب أداء قوي.',
    ),
    const Product(
      id: 'p3',
      title: 'سماعات بلوتوث ',
      price: '8000',
      imageUrl: 'https://picsum.photos/seed/p3/400/300',
      description: 'سماعات بلوتوث عملية.',
    ),
  ];

  List<Product> cart = [];
  double total = 0;

  Product byId(String id) {
    return products.firstWhere((p) => p.id == id);
  }

  void addToCart(Product product) {
    if (!cart.any((p) => p.id == product.id)) {
      cart.add(product);
    }

    recalculateTotal();
    notifyListeners();
  }

  void removeFromCart(Product product) {
    cart.remove(product);
    recalculateTotal();
    notifyListeners();
  }

  double calculateFinalPrice(Product product) {
    double price = double.tryParse(product.price) ?? 0;

    if (price > 10000) {
      price *= 0.90;
    }

    price *= (1 + vatRate);

    return double.parse(price.toStringAsFixed(2));
  }

  void recalculateTotal() {
    total = 0;

    for (var item in cart) {
      total += calculateFinalPrice(item);
    }

    total = double.parse(total.toStringAsFixed(2));
  }
}
