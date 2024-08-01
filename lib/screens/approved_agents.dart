import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApprovedAgentsPage extends StatelessWidget {
  const ApprovedAgentsPage({super.key});

  Future<DocumentSnapshot?> _fetchUserDetails(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      return userDoc;
    } catch (e) {
      print('Error fetching user details: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Approved Agents'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('agentApplications')
            .where('status', isEqualTo: 'approved')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No approved agents found'));
          }

          final agentApplications = snapshot.data!.docs;

          return ListView.builder(
            itemCount: agentApplications.length,
            itemBuilder: (context, index) {
              var application = agentApplications[index];
              String uid = application['uid'];

              return FutureBuilder<DocumentSnapshot?>(
                future: _fetchUserDetails(uid),
                builder: (context, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      title: CircularProgressIndicator(),
                    );
                  }

                  if (userSnapshot.hasError ||
                      !userSnapshot.hasData ||
                      !userSnapshot.data!.exists) {
                    return const ListTile(
                      title: Text('Error fetching user details'),
                    );
                  }

                  var user = userSnapshot.data!.data() as Map<String, dynamic>;

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user['profileUrl'] != null
                          ? NetworkImage(user['profileUrl'])
                          : null,
                      backgroundColor: Colors.grey[400],
                      child: user['profileUrl'] == null
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    title: Text(user['name'] ?? 'Agent Name'),
                    subtitle: Text(user['email'] ?? 'email@example.com'),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
