import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:traffic/screens/login_page.dart';
import 'package:traffic/utils/authentication.dart';
import 'package:traffic/utils/models/usermodel.dart';
import 'package:traffic/utils/providers/userprovider.dart';
import 'package:traffic/widgets/custom_button.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  _logout(BuildContext context) async {
    try {
      print('Current User: ${FirebaseAuth.instance.currentUser}');
      await FirebaseAuth.instance.signOut();
      print('User after sign out: ${FirebaseAuth.instance.currentUser}');

      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove("user");
      sharedPreferences.setBool("isAuthenticated", false);

      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    UserModel? user = ref.watch(userProvider);
    _nameController.text = user?.name ?? '';
    _emailController.text = user?.email ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: user?.profileUrl != null
                    ? NetworkImage(user!.profileUrl)
                    : null,
                backgroundColor: Colors.grey[400],
                child: user?.profileUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                enabled: isEditing,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                enabled: isEditing,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              CustomButton(
                  onPressed: () async {
                    await _logout(context);
                  },
                  txt: "Logout",
                  color: Colors.lightGreen)
            ],
          ),
        ),
      ),
    );
  }
}
