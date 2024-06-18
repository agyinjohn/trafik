import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:traffic/screens/login_page.dart';
import 'package:traffic/screens/sign_up.dart';

import '../utils/onboarding_items.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            itemCount: onboardingData.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return SafeArea(
                child: Container(
                  height: size.height,
                  width: size.width,
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SignUpScreen()));
                          },
                          child: const Text(
                            "Skip",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      CircleAvatar(
                        radius: size.width * 0.4,
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              child: Image.asset(
                                "assets/images/tf.jpeg",
                                height: 200,
                                width: 200,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          onboardingData[_currentPage].title,
                          style: const TextStyle(
                            fontSize: 19.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        onboardingData[_currentPage].description,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              onboardingData.length,
                              (index) => _buildDot(index),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (_currentPage > 0)
                                GestureDetector(
                                  onTap: () {
                                    if (_currentPage >= 1) {
                                      setState(() {
                                        _currentPage--;
                                      });
                                    }
                                  },
                                  child: const CircleAvatar(
                                    radius: 20,
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 15,
                                        color: Colors.lightGreen,
                                      ),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                width: 20,
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.lightGreen,
                                radius: 20,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (_currentPage <
                                          onboardingData.length - 1) {
                                        setState(() {
                                          _currentPage++;
                                        });
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SignUpScreen()));
                                      }
                                    },
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: 30.0,
      height: 3.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: _currentPage == index
            ? Colors.lightGreen
            : Colors.lightGreen.withOpacity(0.5),
      ),
    );
  }
}

// Positioned(
//             bottom: 20.0,
//             left: 20.0,
//             right: 20.0,
//             child: ElevatedButton(
//               onPressed: () {
//                 if (_currentPage < onboardingData.length - 1) {
//                   setState(() {
//                     _currentPage++;
//                   });
//                 } else {
//                   // Navigate to the next screen (e.g., home screen)
//                   Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const LoginScreen()));
//                 }
//               },
//               child: Text(_currentPage < onboardingData.length - 1
//                   ? 'Next'
//                   : 'Get Started'),
//             ),
//           ),
