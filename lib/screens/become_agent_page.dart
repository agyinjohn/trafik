import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
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

  Future<void> _sendEmail() async {
    final smtpServer =
        SmtpServer('smtp.example.com', // Replace with your SMTP server
            username: 'manuelmills318@gmail.com', // Replace with your email
            password: 'nanakwame1'); // Replace with your email password

    final message = Message()
      ..from = const Address('your_email@example.com', 'Your Name')
      ..recipients.add('admin@example.com') // Replace with admin email
      ..subject = 'New Agent Application'
      ..text =
          'Email: ${_emailController.text}\nLocation: ${_locationController.text}\nWorking Hours: ${_workingHoursController.text}\nContact: ${_contactController.text}';

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: $sendReport');
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Application submitted successfully!')));
    } on MailerException catch (e) {
      print('Message not sent. \n${e.toString()}');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to submit application. Please try again.')));
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (agreeToTerms) {
        _sendEmail();
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
          const SizedBox(
            height: 30,
          ),
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
                        hintText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.location_city_outlined),
                        hintText: 'City'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your location';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _workingHoursController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.work),
                        hintText: 'Working Hours'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your working hours';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _contactController,
                    decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(),
                        hintText: 'Contact',
                        prefixIcon: Icon(
                          Icons.phone,
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CheckboxListTile(
                    checkColor: Colors.white,
                    activeColor: Colors.green,
                    title: const Text(
                        'I agree to the terms and conditions of Trafik app'),
                    value: agreeToTerms,
                    onChanged: (value) {
                      setState(() {
                        agreeToTerms = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  CustomButton(
                      onPressed: () {},
                      txt: "Submit Application",
                      color: Colors.lightGreen)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
