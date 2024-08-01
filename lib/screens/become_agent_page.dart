import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traffic/widgets/custom_button.dart';

class AgentApplicationPage extends StatefulWidget {
  const AgentApplicationPage({super.key});

  @override
  AgentApplicationPageState createState() => AgentApplicationPageState();
}

class AgentApplicationPageState extends State<AgentApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  bool agreeToTerms = false;
  bool _isLoading = false;

  Future<void> _submitApplication() async {
    if (_formKey.currentState!.validate()) {
      if (agreeToTerms) {
        setState(() {
          _isLoading = true;
        });

        final User? user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('You must be logged in to apply.')));
          setState(() {
            _isLoading = false;
          });
          return;
        }

        final applicationData = {
          'uid': user.uid,
          'email': _emailController.text,
          'location': _locationController.text,
          'workingHours': _workingHoursController.text,
          'contact': _contactController.text,
          'timestamp': FieldValue.serverTimestamp(),
          'status':
              'pending', // Status can be 'pending', 'approved', 'rejected'
        };

        try {
          // Add application to 'agentApplications' collection
          await FirebaseFirestore.instance
              .collection('agentApplications')
              .add(applicationData);

          // Add/Update user details with role 'user'
          await FirebaseFirestore.instance
              .collection('userDetails')
              .doc(user.uid)
              .set(
                  {
                'uid': user.uid,
                'email': user.email,
                'role': 'user',
              },
                  SetOptions(
                      merge:
                          true)); // Use merge to update if the document exists

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Application submitted successfully!')));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content:
                  Text('Failed to submit application. Please try again.')));
        } finally {
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You must agree to the terms and conditions.')));
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _locationController.dispose();
    _workingHoursController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Agent Application'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      hintText: "Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_city_outlined),
                      hintText: 'City',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _workingHoursController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.work),
                      hintText: 'Working Hours',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your working hours';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(),
                      hintText: 'Contact',
                      prefixIcon: Icon(Icons.phone),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    title: const Text(
                        'I agree to the terms and conditions of the Trafik app'),
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          onPressed: _submitApplication,
                          txt: "Submit Application",
                          color: Colors.lightGreen,
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
