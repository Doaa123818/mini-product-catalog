import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String username = 'Guest';

  // Lifecycle: initState
  @override
  void initState() {
    super.initState();
    print('LoginPage: initState');
  }

  // Lifecycle: didChangeDependencies
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('LoginPage: didChangeDependencies');
  }

  // Lifecycle: build
  @override
  Widget build(BuildContext context) {
    print('LoginPage: build');

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Mini Product Catalog',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 20),

            TextField(
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                username = value;
              },
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final user = username.trim().isEmpty
                      ? 'Guest'
                      : username.trim();

                  // Navigator version:
                  //
                  // Navigator.of(context).pushNamed(
                  //   '/products',
                  //   arguments: user,
                  // );

                  // go_router version:
                  context.goNamed('products', queryParameters: {'user': user});
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Lifecycle: deactivate
  @override
  void deactivate() {
    print('LoginPage: deactivate');
    super.deactivate();
  }

  // Lifecycle: dispose
  @override
  void dispose() {
    print('LoginPage: dispose');
    super.dispose();
  }
}
