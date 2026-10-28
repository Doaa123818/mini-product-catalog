import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'product_widgets.dart';
import 'details_page.dart';

class ProductsPage extends StatefulWidget {
  final String username;

  ProductsPage({required this.username});

  @override
  State<ProductsPage> createState() {
    return ProductsPageState();
  }
}

class ProductsPageState extends State<ProductsPage> {
  int favorites = 0;

  String cartMessage = '';

  Size screenSize = Size.zero;

  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Phone', 'price': 800},
    {'name': 'Headphones', 'price': 150},
    {'name': 'Keyboard', 'price': 90},
    {'name': 'Mouse', 'price': 50},
    {'name': 'Monitor', 'price': 400},
    {'name': 'Tablet', 'price': 500},
    {'name': 'Smart Watch', 'price': 250},
  ];

  // Lifecycle: initState
  @override
  void initState() {
    super.initState();
    print('ProductsPage: initState');
  }

  // Lifecycle: didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    screenSize = MediaQuery.sizeOf(context);

    print(
      'ProductsPage: didChangeDependencies -> '
      'width: ${screenSize.width}, '
      'height: ${screenSize.height}',
    );
  }

  // Lifecycle: build
  @override
  Widget build(BuildContext context) {
    print('ProductsPage: build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, ${widget.username}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            Text('Favorites: $favorites'),

            const SizedBox(height: 8),

            Text('Screen width: ${screenSize.width}'),

            const SizedBox(height: 8),

            if (cartMessage.isNotEmpty)
              Text(cartMessage, style: const TextStyle(color: Colors.green)),

            const SizedBox(height: 12),

            Expanded(
              child: screenSize.width < 600
                  ? ProductsListView(
                      products: products,

                      onFavoritePressed: () {
                        setState(() {
                          favorites++;
                        });
                      },

                      onProductTap: (index) {
                        openProductDetails(index);
                      },
                    )
                  : ProductsGridView(
                      products: products,

                      onFavoritePressed: () {
                        setState(() {
                          favorites++;
                        });
                      },

                      onProductTap: (index) {
                        openProductDetails(index);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // Products -> Details
  Future<void> openProductDetails(int index) async {
    final product = products[index];

    final name = product['name'] as String;
    final price = product['price'] as int;

    // Navigator version:
    //
    // final result = await Navigator.of(context).push<String>(
    //   MaterialPageRoute(
    //     builder: (context) => DetailsPage(
    //       name: name,
    //       price: price.toDouble(),
    //     ),
    //   ),
    // );
    //
    // if (result != null && mounted) {
    //   setState(() {
    //     cartMessage = result;
    //   });
    // }

    // go_router version:
    final result = await context.push<String>(
      '/details/${Uri.encodeComponent(name)}/$price',
    );

    if (!mounted) return;

    if (result != null) {
      setState(() {
        cartMessage = result;
      });
    }
  }

  // Lifecycle: deactivate
  @override
  void deactivate() {
    print('ProductsPage: deactivate');
    super.deactivate();
  }

  // Lifecycle: dispose
  @override
  void dispose() {
    print('ProductsPage: dispose');
    super.dispose();
  }
}
