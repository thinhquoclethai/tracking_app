import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String _ip;
  late double _speed;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ip = ModalRoute.of(context)!.settings.arguments! as String;
    _speed = 0.0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết nối với địa chỉ $_ip',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const SizedBox(
              height: 16,
            ),
            Text(
              _speed.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 57,
                height: 64 / 57,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Không có cảnh báo nguy hiểm',
              style: TextStyle(
                fontSize: 16,
                height: 24 / 16,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text('Gọi cấp cứu'),
                  onPressed: () {
                    launchUrl(Uri(scheme: 'tel', path: '115'));
                  },
                ),
              ],
            ),
            const Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
