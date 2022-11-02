import 'package:flutter/material.dart';
import 'package:tracking_app/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _ipTextController;
  bool isValid = false;

  @override
  void initState() {
    super.initState();
    _ipTextController = TextEditingController()
      ..addListener(() {
        if (_ipTextController.text.isEmpty) {
          setState(() {
            isValid = false;
          });
        } else {
          setState(() {
            isValid = true;
          });
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16) +
              const EdgeInsets.only(top: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                'Car Tracking App',
                style: TextStyle(
                  fontSize: 45,
                  height: 52 / 45,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              const Text(
                'IP Address',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _ipTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Địa chỉ IP',
                  hintText: 'Nhập địa chỉ IP của thiết bị ở đây',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: !isValid
                      ? null
                      : () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => HomePage(
                                ip: _ipTextController.text,
                              ),
                            ),
                          ),
                  child: const Text('Truy cập'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
