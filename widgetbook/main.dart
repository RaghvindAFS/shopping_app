import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/auth.dart';
import 'package:shopping_app/providers/cart.dart';
import 'package:shopping_app/providers/orders.dart';
import 'package:shopping_app/providers/product.dart';
import 'package:shopping_app/providers/products_provider.dart';
import 'package:shopping_app/screens/auth_screen.dart';
import 'package:shopping_app/screens/cart_screen.dart';
import 'package:shopping_app/screens/edit_product_screen.dart';
import 'package:shopping_app/screens/orders_screen.dart';
import 'package:shopping_app/screens/product_detail_screen.dart';
import 'package:shopping_app/screens/products_overview_screen.dart';
import 'package:shopping_app/screens/user_products_screen.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:shopping_app/widgets/app_drawer.dart';
import 'package:shopping_app/widgets/badge.dart';
import 'package:shopping_app/widgets/cart_item.dart' as ct;
import 'package:shopping_app/widgets/order_item.dart' as ot;
import 'package:shopping_app/widgets/product_grid.dart';
import 'package:shopping_app/widgets/product_item.dart';
import 'package:shopping_app/widgets/splash_screen.dart';
import 'package:shopping_app/providers/orders.dart' as ord;
import 'package:shopping_app/widgets/user_product_item.dart';
import './mockProvider/mock_providers.dart';

void main() {
  runApp(HotreloadWidgetbook());
}

class HotreloadWidgetbook extends StatefulWidget {
  @override
  State<HotreloadWidgetbook> createState() => _HotreloadWidgetbookState();
}

class _HotreloadWidgetbookState extends State<HotreloadWidgetbook> {
  @override //runs before app  runs
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts();  // Won't work
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Products>(context).fetchAndSetProducts();
    });
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(create: (_) => MockAuth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (ctx) => MockProducts(),
          update: (ctx, auth, previousProducts) => MockProducts(
              // auth.token,
              // auth.userId,
              // previousProducts == null ? [] : previousProducts.items
              ),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => MockCart(),
        ),
        ChangeNotifierProvider<Product>(create: (_) => MockProduct()),
        ChangeNotifierProxyProvider<Auth, Orders>(
          create: (_) => MockOrders(),
          update: (ctx, auth, previousOrder) => MockOrders(
              // auth.token, previousOrder == null ? [] : previousOrder.orders
              ),
        ),
      ],
      child: Widgetbook.material(
        categories: [
          WidgetbookCategory(
            name: 'creens',
            widgets: [
              WidgetbookComponent(
                name: 'Auth',
                useCases: [
                  WidgetbookUseCase(
                      name: 'AuthScreen', builder: (context) =>AuthScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'Cart',
                useCases: [
                  WidgetbookUseCase(
                      name: 'CartScreen', builder: (context) =>CartScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'Product',
                useCases: [
                  WidgetbookUseCase(
                      name: 'EditProductScreen', builder: (context) =>EditProductScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'Orders',
                useCases: [
                  WidgetbookUseCase(
                      name: 'OrderScreen', builder: (context) =>OrdersScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'Detail',
                useCases: [
                  WidgetbookUseCase(
                      name: 'ProductDetailScreen', builder: (context) =>ProductDetailScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'ProductOverview',
                useCases: [
                  WidgetbookUseCase(
                      name: 'ProductOverviewScreen', builder: (context) =>ProductOverviewScreen()),
                      
                ],
              ),
              WidgetbookComponent(
                name: 'user Product',
                useCases: [
                  WidgetbookUseCase(
                      name: 'UserProductScreen', builder: (context) =>UserProductsScreen()),
                      
                ],
              ),
            ]
            ),
          WidgetbookCategory(
            name: 'widgets',
            widgets: [
              WidgetbookComponent(
                name: 'Drawer',
                useCases: [
                  WidgetbookUseCase(
                      name: 'App Drawer', builder: (context) => AppDrawer()),
                ],
              ),
              WidgetbookComponent(
                name: 'Badge',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Badge',
                      builder: (context) => Badge(
                            value: '5',
                            child: Container(),
                          )),
                ],
              ),
              WidgetbookComponent(
                name: 'Cart',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Cart Item',
                      builder: (context) =>
                          ct.CartItem('id', 'productId', 25.6, 5, 'title')),
                ],
              ),
              WidgetbookComponent(
                name: 'Order',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Order Item',
                      builder: (context) => ot.OrderItem(ord.OrderItem(
                          amount: 100,
                          dateTime: DateTime.now(),
                          id: 'id',
                          products: []))),
                ],
              ),
              WidgetbookComponent(
                name: 'Grid',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Product Grid',
                      builder: (context) => ProductGrid(false)),
                ],
              ),
              WidgetbookComponent(
                name: 'Product',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Product Item',
                      builder: (context) => ProductItem()),
                ],
              ),
              WidgetbookComponent(
                name: 'Screen',
                useCases: [
                  WidgetbookUseCase(
                      name: 'Splash Screen',
                      builder: (context) => SplashScreen()),
                ],
              ),
              WidgetbookComponent(
                name: 'User Product',
                useCases: [
                  WidgetbookUseCase(
                      name: 'User Product Item',
                      builder: (context) =>
                          UserProductItem('id', 'title', 'url')),
                ],
              ),
            ],
          ),
        ],
        themes: [
          WidgetbookTheme(
            name: 'Light',
            data: ThemeData.light(),
          ),
          WidgetbookTheme(
            name: 'Dark',
            data: ThemeData.dark(),
          ),
        ],
        appInfo: AppInfo(name: 'My Shop'),
      ),
    );
  }
}
