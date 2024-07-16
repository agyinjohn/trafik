import 'package:flutter/material.dart';

class AlternativeRoutePage extends StatefulWidget {
  const AlternativeRoutePage({super.key});

  @override
  State<AlternativeRoutePage> createState() => _AlternativeRoutePageState();
}

class _AlternativeRoutePageState extends State<AlternativeRoutePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Alternative routes \navailable",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 25,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 210, 213, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Fastest", style: TextStyle(color: Colors.black54)),
                    Text(
                      "Railway road",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 210, 213, 208),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Another alternative",
                        style: TextStyle(color: Colors.black54)),
                    Text(
                      "Oyinbo",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 129, 190, 88),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    "Suggest another",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightGreen),
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Center(
                  child: Text(
                    "Go back",
                    style: TextStyle(
                        color: Colors.lightGreen,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
