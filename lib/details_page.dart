import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatefulWidget {
  final String name;
  final double price;

  DetailsPage({required this.name, required this.price});

  @override
  State<DetailsPage> createState() {
    return DetailsPageState();
  }
}

class DetailsPageState extends State<DetailsPage> {
  // Lifecycle: initState
  @override
  void initState() {
    super.initState();
    print('DetailsPage: initState');
  }

  // Lifecycle: didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('DetailsPage: didChangeDependencies');
  }

  // Lifecycle: build
  @override
  Widget build(BuildContext context) {
    print('DetailsPage: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Product Details')),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Price: \$${widget.price.toStringAsFixed(0)}',
                style: const TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  // Navigator version:
                  //
                  // Navigator.pop(
                  //   context,
                  //   '${widget.name} added to cart',
                  // );

                  // go_router version:
                  context.pop('${widget.name} added to cart');
                },
                child: const Text('Add to Cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Lifecycle: deactivate
  @override
  void deactivate() {
    print('DetailsPage: deactivate');
    super.deactivate();
  }

  // Lifecycle: dispose
  @override
  void dispose() {
    print('DetailsPage: dispose');
    super.dispose();
  }
}
