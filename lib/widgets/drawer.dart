import 'package:flutter/material.dart';

import 'package:traffic/screens/about_page.dart';
import 'package:traffic/screens/display_update.dart';
import 'package:traffic/screens/hire_agent_page.dart';

import 'package:traffic/screens/support_page.dart';

import 'package:traffic/screens/upload_page.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key, required this.url, required this.name});
  final String url;
  final String name;
  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.url),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(widget.name),
                ],
              ),
            ),
          ),
          const Divider(
            color: Colors.grey,
            height: 0.2,
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DisplayPostsPage())),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.traffic,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Traffic Update"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UploadForm())),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.report,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Make road report"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HireAgentPage())),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.support_agent,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Hire agent"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (concontext) => const SupportPage())),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.help,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Support"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage())),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: Colors.lightGreen,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("About"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.lightGreen,
              ),
              child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Become an agent',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
