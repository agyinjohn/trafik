import 'package:flutter/material.dart';
import 'package:traffic/screens/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
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
  bool _obscurePassword = true;
  final bool _obscureConfirmPassword = true;
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

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Implement your login logic here
      final email = _emailController.text;
      final password = _passwordController.text;

      // Mock login logic (replace with your authentication logic)
      if (email == 'test@example.com' && password == 'password') {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SlideTransition(
                  position: _textSlideAnimation,
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      'Traffik',
                      style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
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
                      Text("Don\'t have an account?"),
                      TextButton(
                        onPressed: () {
                          // Navigate to sign up screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
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
    );
  }
}
