import 'package:api_calling/pages/home_page.dart';
import 'package:api_calling/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = FlutterSecureStorage();

Stream<bool> refreshTokenStream() async* {
  final token = await storage.read(key: 'refreshToken');
  yield token != null;
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: refreshTokenStream(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data == true) {
          return HomePage();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(
              context,
            ).pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
          });
          // return an empty contaier while navigator occurs
          return Container();
        }
      },
    );
  }
}
