import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'FAQ',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'What are the responsibilities of a traffic management agent?\n'
              'A traffic management agent is responsible for monitoring traffic conditions, reporting accidents, providing real-time updates, and offering traffic management tools and services.\n'
              'How can I become a traffic management agent?\n'
              'Sign up on our platform and apply for the agent role. Once approved, you will have access to various tools and services to help manage traffic effectively.\n'
              'What benefits do traffic management agents receive?\n'
              'Benefits include access to real-time traffic data, opportunities to offer services to the mass, and the ability to contribute to improving overall traffic conditions.\n'
              'Can traffic management agents be hired for specific tasks?\n'
              'Yes, they can be hired for tasks such as tracking traffic patterns, conducting surveys, and selling specialized traffic products.\n'
              'Are there any training resources available for traffic management agents?\n'
              'Yes, we provide training resources and support to enhance their skills and knowledge in managing traffic effectively.',
            ),
            SizedBox(height: 16),
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Email\n'
              'For technical support, please email techsupport@trafikapp.com\n'
              'info@trafikapp.com\n\n'
              'Phone\n'
              '+233 594971305',
            ),
          ],
        ),
      ),
    );
  }
}
