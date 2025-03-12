import 'package:flutter/material.dart';
import 'package:voidlord/pages/test/controller.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
            onPressed: () {
              TestController.addFile();
            },
            icon: Icon(
              Icons.add_box_outlined,
              color: Colors.grey,
              size: 100,
            )),
      ),
    );
  }
}
