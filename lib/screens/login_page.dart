// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:traffic/screens/home_screen.dart';

import 'package:traffic/screens/mappage.dart';
import 'package:traffic/screens/sign_up.dart';
import 'package:traffic/utils/authentication.dart';
import 'package:traffic/utils/commons.dart';
import 'package:traffic/widgets/animated_background.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerLoginScreenState createState() => ConsumerLoginScreenState();
}

class ConsumerLoginScreenState extends ConsumerState<LoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _emailControllerAnim;
  late AnimationController _passwordControllerAnim;
  late AnimationController _buttonControllerAnim;
  late AnimationController _textControllerAnim;

  late Animation<Offset> _emailSlideAnimation;
  late Animation<Offset> _passwordSlideAnimation;
  late Animation<Offset> _buttonSlideAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _fadeAnimation;
  bool isLoading = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();

    _emailControllerAnim = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _passwordControllerAnim = AnimationController(
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

    _emailSlideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _emailControllerAnim,
      curve: Curves.easeInOut,
    ));

    _passwordSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _passwordControllerAnim,
      curve: Curves.easeInOut,
    ));

    _buttonSlideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _buttonControllerAnim,
      curve: Curves.easeInOut,
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

    _textControllerAnim.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _emailControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _passwordControllerAnim.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _buttonControllerAnim.forward();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailControllerAnim.dispose();
    _passwordControllerAnim.dispose();
    _buttonControllerAnim.dispose();
    _textControllerAnim.dispose();
    super.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      // Implement your login logic here
      final email = _emailController.text;
      final password = _passwordController.text;

      // Mock login logic (replace with your authentication logic)
      try {
        setState(() {
          isLoading = true;
        });
        final res = await ref.read(authMethodProvider).signInUser(
              context: context,
              email: email,
              password: password,
            );
        if (res) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));

          showSnackBar(context, "Login Successfull");
        }
        setState(() {
          isLoading = false;
        });
      } catch (err) {
        setState(() {
          isLoading = false;
        });
        showSnackBar(context, err.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const CircularAnimationBackground(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white.withOpacity(0.90),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        'Welcome, \nPlease Login to Traffik for Best Experince',
                        style: TextStyle(
                          fontSize: 31.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
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
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(value)) {
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
                            position: _buttonSlideAnimation,
                            child: SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: _login,
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
                                child: const Text('Login'),
                              ),
                            ),
                          ),
                          SlideTransition(
                            position: _buttonSlideAnimation,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Don't have an account?"),
                                TextButton(
                                  onPressed: () {
                                    // Navigate to sign up screen
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpScreen()));
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.blueAccent,
                                    textStyle: const TextStyle(fontSize: 16.0),
                                  ),
                                  child: const Text('Sign up'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            child: Center(
              child: Container(
                width: 70,
                height: 70,
                color: Colors.blueGrey,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
