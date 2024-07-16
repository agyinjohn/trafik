import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:timeago/timeago.dart' as timeago;

class DisplayPostsPage extends StatelessWidget {
  const DisplayPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic updates'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              underline: Container(),
              icon: const Icon(Icons.filter_list),
              items: <String>['Near to me', 'All updates'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (value) {
                // Implement filter logic here
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('trafficUpdates')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var post = snapshot.data!.docs[index];
              DateTime postTime = (post['timestamp'] as Timestamp).toDate();
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(post['image_url']),
                    radius: 30.0,
                  ),
                  title: Text(post['comment']),
                  subtitle:
                      Text('${timeago.format(postTime)} • ${post['city']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Implement details view logic
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Details'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
