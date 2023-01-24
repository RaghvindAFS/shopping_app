import 'package:flutter/cupertino.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shopping_app/providers/auth.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/providers/product.dart';
import 'package:shopping_app/providers/products_provider.dart';

class MockAuth extends Mock implements Auth {
  String get token {
    
      return "eyJhbGciOiJSUzI1NiIsImtpZCI6ImQwNTU5YzU5MDgzZDc3YWI2NDUxOThiNTIxZmM4ZmVmZmVlZmJkNjIiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL3NlY3VyZXRva2VuLmdvb2dsZS5jb20vcmFnaHZpbmQtZG1qaSIsImF1ZCI6InJhZ2h2aW5kLWRtamkiLCJhdXRoX3RpbWUiOjE2NzQ0NjUzNjQsInVzZXJfaWQiOiJ2dHYzMU5GZXF3YUIyS1o5M3JkMGY3TFZ6dngxIiwic3ViIjoidnR2MzFORmVxd2FCMktaOTNyZDBmN0xWenZ4MSIsImlhdCI6MTY3NDQ2NTM2NCwiZXhwIjoxNjc0NDY4OTY0LCJlbWFpbCI6InNoaXZhbUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6ZmFsc2UsImZpcmViYXNlIjp7ImlkZW50aXRpZXMiOnsiZW1haWwiOlsic2hpdmFtQGdtYWlsLmNvbSJdfSwic2lnbl9pbl9wcm92aWRlciI6InBhc3N3b3JkIn19.SU1B65f0i92IvTJn-e8lb4vucokJBJwg9QXqFlq317QGtgFSaqPxjOwl65rjPesJuETwY4a1OtZtPL8s09K3FDladKhcFyp-kmcg4RPisMJ0JoADPQFfiKakDl_rV1XlD7BVIL1KCMLDc9JCktQDry5NzAg1eDvom11alUIf7SMunzyVIqOTgqHBCjFDGhjn0as3gIbgIJVqnjVYSKP3NLd_kV42Xl-RBwLbYauFXVGyEaIkNA39QZoUK1SGUaf3m3KLH3yAkC07ZAG_3mx_SF3irnKFs8ZnCeaYCKDV15AkqgDeQC_90DOarc0sFfEQ0hfFswtNPbfpgvBYpQpP2g";
        
  }

  String get userId {
    //mainly used for favorite items list
    return 'vtv31NFeqwaB2KZ93rd0f7LVzvx1';
  }
}

class MockCart extends Mock implements Cart {
 printFun(){
  return debugPrint('printed mock cart');
 }
 int get itemCount {
   return _items.length;
 }
   Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }
  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, CartItem) {
      total += CartItem.price * CartItem.quantity;
    });
    return total;
  }
  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      //change quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
                id: DateTime.now().toString(),
                title: title,
                price: price,
                quantity: 1,
              ));
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]?.quantity != 1) {
      _items.update(
          productId,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity - 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
class MockProduct extends Mock implements Product{
  final String id='p1';
  final String title= 'Red Shirt';
  final String description='A red shirt - it is pretty red!';
  final double price=29.99;
  final String imageUrl='https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg';
  bool isFavorite  = false;
}
class MockProducts extends Mock implements Products {

   List<Product> _items  = [
      Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      ),
      Product(
        id: 'p2',
        title: 'Trousers',
        description: 'A nice pair of trousers.',
        price: 59.99,
        imageUrl:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
      ),
      Product(
          id: 'p3',
          title: 'Yellow Scarf',
          description: 'Warm and cozy - exactly what you need for the winter.',
          price: 19.99,
          imageUrl:
              'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
          isFavorite: false),
      Product(
          id: 'p4',
          title: 'A Pan',
          description: 'Prepare any meal you want.',
          price: 49.99,
          imageUrl:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
          isFavorite: false),
    ];

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    debugPrint('_items:${_items}');
    return _items;
  }

  List<Product> get favoritesItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
   Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}

class MockOrders extends Mock implements Orders {
  List<OrderItem> _orders=[];


  List<OrderItem> get orders {
    return _orders;
  }
  Future<void> fetchAndSetOrders() async {
    _orders  = [
      OrderItem(
        amount: 500,
        dateTime: DateTime.now(),
        id: 'o1',
        products: [
          CartItem(
            id: 'p1',
            price: 200,
            quantity: 2,
            title: 'Red Shirt',
          ),
          CartItem(
            id: 'p2',
            price: 300,
            quantity: 1,
            title: 'Sweater',
          )
        ],

      ),
      OrderItem(
        amount: 800,
        dateTime: DateTime.now(),
        id: 'o2',
        products: [
          CartItem(
            id: 'p1',
            price: 200,
            quantity: 2,
            title: 'Red Shirt',
          ),
          CartItem(
            id: 'p2',
            price: 300,
            quantity: 1,
            title: 'Sweater',
          )
        ],

      ),
    ];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {

    _orders.insert(
        0,
        OrderItem(
            id: 'o3',
            amount: 400,
            products: [
              CartItem(
                id: 'p3',
                price: 600,
                quantity: 2,
                title: 'jeans',
              ),
              CartItem(
                id: 'p4',
                price: 300,
                quantity: 1,
                title: 'trouser',
              )
            ],
            dateTime: DateTime.now()));

  }
}
