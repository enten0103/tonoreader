import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          '管理',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
