import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  Future<void> _updateUserRole(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('userDetails')
          .doc(uid)
          .update({
        'role': 'agent',
      });
      print('User role updated to agent');
    } catch (e) {
      print('Failed to update user role: $e');
    }
  }

  Future<void> _approveApplication(String docId, String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection('agentApplications')
          .doc(docId)
          .update({'status': 'approved'});
      print('Application approved');
      await _updateUserRole(uid);
    } catch (e) {
      print('Failed to approve application: $e');
    }
  }

  Future<void> _rejectApplication(String docId) async {
    try {
      await FirebaseFirestore.instance
          .collection('agentApplications')
          .doc(docId)
          .update({'status': 'rejected'});
      print('Application rejected');
    } catch (e) {
      print('Failed to reject application: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('agentApplications')
            .where('status', isEqualTo: 'pending')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'No pending applications',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var application = snapshot.data!.docs[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  title: Text(application['email']),
                  subtitle: Text('Location: ${application['location']}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => _approveApplication(
                            application.id, application['uid']),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _rejectApplication(application.id),
                      ),
                    ],
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
