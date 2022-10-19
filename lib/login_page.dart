import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _ipTextController;

  @override
  void initState() {
    super.initState();
    _ipTextController = TextEditingController();
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
                  labelText: 'Ip',
                  hintText: 'Nhập địa chỉ Ip của thiết bị ở đây',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _ipTextController.text.isEmpty
                      ? null
                      : () => Navigator.of(context).pushNamed(
                            '/home',
                            arguments: _ipTextController.text,
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
