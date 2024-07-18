import 'package:flutter/material.dart';

class EstimatedTimePage extends StatefulWidget {
  const EstimatedTimePage({super.key});

  @override
  State<EstimatedTimePage> createState() => _EstimatedTimePageState();
}

class _EstimatedTimePageState extends State<EstimatedTimePage> {
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
              "Extimated time of \ntravel",
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(
              height: 25,
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
                    Text("Traffic level",
                        style: TextStyle(color: Colors.black54)),
                    Text(
                      "Minimal",
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
                    Text("Distance", style: TextStyle(color: Colors.black54)),
                    Text(
                      "12 miles",
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
                    Text("Normal Travel time",
                        style: TextStyle(color: Colors.black54)),
                    Text(
                      "8 mins",
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
                    Text("Extimated travel time",
                        style: TextStyle(color: Colors.black54)),
                    Text(
                      "30 mins",
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
                    "Check Alternatives",
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
