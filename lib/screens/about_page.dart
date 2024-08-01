import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'Version: 1.0.0', // Update the version accordingly
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'App Overview',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Trafikapp is an innovative platform designed to provide users with real-time traffic updates, accurate travel time estimates, multiple alternative routes, and transportation mode recommendations. Our system ensures a seamless and efficient commute, whether you are driving, taking public transport, cycling, or walking.',
            ),
            SizedBox(height: 16),
            Text(
              'App Features',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '• Estimated time of arrival: Provides expected arrival time based on current traffic conditions and chosen route and mode of transport, helping in effective journey planning.\n'
              '• Alternate routes: Offers different route options to avoid congested areas or road closures.\n'
              '• Suitable transport modes: Suggests various transport modes best suited for the journey.\n'
              '• Traffic updates: Provides real-time updates on traffic conditions.\n'
              '• Make traffic reports: Enables users to report traffic conditions or incidents.\n'
              '• Hire agents: Allows users to hire agents for transportation-related tasks.\n'
              '• Become an agent: Provides opportunities for individuals to register as agents and offer their services.',
            ),
          ],
        ),
      ),
    );
  }
}
