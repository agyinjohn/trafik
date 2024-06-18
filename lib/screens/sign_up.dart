import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:traffic/screens/login_page.dart';

import '../utils/commons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Uint8List? image;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _nameControllerAnim;
  late AnimationController _emailControllerAnim;
  late AnimationController _passwordControllerAnim;
  late AnimationController _confirmPasswordControllerAnim;
  late AnimationController _buttonControllerAnim;
  late AnimationController _textControllerAnim;

  late Animation<Offset> _nameSlideAnimation;
  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
  late Animation<Offset> _confirmPasswordSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _fadeAnimation;

  pickeProfilePic() async {
    Uint8List? pickedImage = await pickImageFromGallery();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

//  image == null
//                       ? const CircleAvatar(
//                           radius: 64,
//                           backgroundImage: AssetImage(
//                             'assets/images/pic_profile.jpg',
//                           ),
//                         )
//                       : CircleAvatar(
//                           radius: 64,
//                           backgroundColor: Colors.grey,
//                           backgroundImage: MemoryImage(image!),
//                         ),

  @override
  void initState() {
    super.initState();

    _nameControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _emailControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _passwordControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _confirmPasswordControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _buttonControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _textControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _nameSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _nameControllerAnim,
      curve: Curves.easeInOut,
    ));

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _emailControllerAnim,
      curve: Curves.easeInOut,
    ));

    _passwordSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _passwordControllerAnim,
      curve: Curves.easeInOut,
    ));

    _confirmPasswordSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _confirmPasswordControllerAnim,
      curve: Curves.easeInOut,
    ));

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonControllerAnim,
      curve: Curves.bounceInOut,
    ));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textControllerAnim,
      curve: Curves.easeInOut,
    ));

    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _textControllerAnim,
      curve: Curves.easeIn,
    ));

    Future.delayed(const Duration(milliseconds: 300), () {
      _nameControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _emailControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _passwordControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      _confirmPasswordControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      _buttonControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 2000), () {
      _textControllerAnim.forward();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameControllerAnim.dispose();
    _emailControllerAnim.dispose();
    _passwordControllerAnim.dispose();
    _confirmPasswordControllerAnim.dispose();
    _buttonControllerAnim.dispose();
    _textControllerAnim.dispose();
    super.dispose();
  }

  void _signUp() {
    if (_formKey.currentState!.validate()) {
      // Implement your sign-up logic here
      final name = _nameController.text;
      final email = _emailController.text;
      final password = _passwordController.text;
      final confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }

      // Mock sign-up logic (replace with your authentication logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sign-up successful for $name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.purple,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Create Trafik Account",
              style: TextStyle(color: Colors.lightGreen, fontSize: 30),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        image == null
                            ? const CircleAvatar(
                                radius: 60,
                                backgroundImage:
                                    AssetImage("assets/images/tf.jpeg"),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.lightGreen,
                                backgroundImage: MemoryImage(image!),
                              ),
                        Positioned(
                          bottom: -90,
                          top: 0,
                          right: -5,
                          child: GestureDetector(
                            onTap: pickeProfilePic,
                            child: CircleAvatar(
                              backgroundColor: Colors.lightGreen,
                              radius: 20,
                              child: IconButton(
                                  color: Colors.white,
                                  onPressed: pickeProfilePic,
                                  icon: const Icon(Icons.add_a_photo)),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SlideTransition(
                      position: _nameSlideAnimation,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SlideTransition(
                      position: _emailSlideAnimation,
                      child: TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          filled: true,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SlideTransition(
                      position: _passwordSlideAnimation,
                      child: TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SlideTransition(
                      position: _confirmPasswordSlideAnimation,
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Confirm Password',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        obscureText: _obscureConfirmPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    SlideTransition(
                      position: _buttonSlideAnimation,
                      child: SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _signUp,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 24.0),
                            textStyle: const TextStyle(fontSize: 18.0),
                          ),
                          child: const Text('Sign Up'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _textSlideAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                              onPressed: () {
                                // Navigate to login screen
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blueAccent,
                                textStyle: const TextStyle(fontSize: 16.0),
                              ),
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
