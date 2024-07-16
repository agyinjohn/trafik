import 'package:flutter/material.dart';
import 'package:traffic/widgets/drawer.dart';

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const SideDrawer(
        name: "John",
        url:
            "https://firebasestorage.googleapis.com/v0/b/trafik-df17f.appspot.com/o/profile-pic%2F2ElCbQhHJOMEQszOzjwEhIEspPQ2?alt=media&token=4bcc6df7-5d97-4375-80fa-8b39b48d73f1",
      ),
    );
  }
}
