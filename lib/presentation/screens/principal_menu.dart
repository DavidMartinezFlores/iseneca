import 'package:flutter/material.dart';
import 'package:iseneca/models/user.dart';
class PrincipalMenu extends StatelessWidget {
  final User user;
  const PrincipalMenu({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Logeado"),
    );
  }
}