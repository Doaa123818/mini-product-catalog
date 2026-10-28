/*
============================================================
Mini Product Catalog
State Lifecycle & Navigation
============================================================

PART 1 - Lifecycle

a) Which methods run when a page opens for the first time?

initState(), didChangeDependencies(), and build().

b) Which method runs again after pressing the heart button?

setState() schedules build() to run again.

c) Which methods run when leaving a page and going back?

deactivate() runs when the State is removed from the widget tree.
dispose() runs when the State is permanently removed.
build() may run again when returning to a preserved page.

d) Which methods run when resizing the browser window, and why?

build() runs to update the UI.
didChangeDependencies() may run again because MediaQuery changes.
The layout changes according to the screen width.

PART 4 - Short Answers

1) context.go navigates to a destination.
   context.push adds a page to the navigation stack.

   Example:
   Login -> Products: goNamed()
   Products -> Details: push()

2) We use go for Login -> Products because we want to navigate
   to the Products destination.
   We use push for Products -> Details because we want to return
   to the previous Products page and receive a result.

3) A path parameter is part of the URL path:
   /details/Laptop/1200

   A query parameter comes after ?:
   /products?user=Guest

============================================================
*/

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'login_page.dart';
import 'products_page.dart';
import 'details_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return LoginPage();
      },
    ),

    GoRoute(
      name: 'products',
      path: '/products',
      builder: (context, state) {
        final username = state.uri.queryParameters['user'] ?? 'Guest';

        return ProductsPage(username: username);
      },
    ),

    GoRoute(
      name: 'details',
      path: '/details/:name/:price',
      builder: (context, state) {
        final name = state.pathParameters['name'] ?? 'Unknown';

        final price =
            double.tryParse(state.pathParameters['price'] ?? '') ?? 0.0;

        return DetailsPage(name: name, price: price);
      },
    ),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigator version:
    //
    // return MaterialApp(
    //   home: LoginPage(),
    // );

    // Active version: go_router
    return MaterialApp.router(
      title: 'Mini Product Catalog',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
