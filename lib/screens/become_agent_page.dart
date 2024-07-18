import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class AgentApplicationPage extends StatefulWidget {
  const AgentApplicationPage({super.key});

  @override
  AgentApplicationPageState createState() => AgentApplicationPageState();
}

class AgentApplicationPageState extends State<AgentApplicationPage> {
  final _formKey = GlobalKey<FormState>();
  String email = '';
  String location = '';
  String workingHours = '';
  bool agreeToTerms = false;

  Future<void> _sendEmail() async {
    final smtpServer = SmtpServer(
        'smtp.example.com', // Replace with your SMTP server
        username: 'your_email@example.com', // Replace with your email
        password: 'your_email_password'); // Replace with your email password

    final message = Message()
      ..from = const Address('your_email@example.com', 'Your Name')
      ..recipients.add('admin@example.com') // Replace with admin email
      ..subject = 'New Agent Application'
      ..text =
          'Email: $email\nLocation: $location\nWorking Hours: $workingHours';

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
        _formKey.currentState!.save();
        _sendEmail();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('You must agree to the terms and conditions.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agent Application'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your location';
                  }
                  return null;
                },
                onSaved: (value) {
                  location = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Working Hours'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your working hours';
                  }
                  return null;
                },
                onSaved: (value) {
                  workingHours = value!;
                },
              ),
              CheckboxListTile(
                title: const Text(
                    'I agree to the terms and conditions of Trafik app'),
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
