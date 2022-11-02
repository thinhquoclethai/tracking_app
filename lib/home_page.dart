import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.ip});

  final String ip;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// mode = 1 -> Duong do thi
  ///
  /// mode = 2 -> Duong cao toc
  int mode = 1;
  String speedWarningMessage = 'Không có cảnh báo nguy hiểm';
  String distanceWarningMessage = 'Không có cảnh báo nguy hiểm';

  late final WebSocketChannel _channelSpeed;
  late final WebSocketChannel _channelDistance;

  @override
  void initState() {
    super.initState();
    _channelSpeed = WebSocketChannel.connect(Uri.parse('ws://${widget.ip}'));
    _channelDistance = WebSocketChannel.connect(Uri.parse('ws://${widget.ip}'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kết nối với địa chỉ ${widget.ip}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Text(
              'Vận tốc',
              style: theme.textTheme.displayLarge
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            StreamBuilder(
              stream: _channelSpeed.stream,
              builder: (context, snapshot) {
                var speed = '';
                if (snapshot.hasData) {
                  try {
                    final data = snapshot.data as String;
                    final speedDistance =
                        data.substring(data.length - 7, data.length);
                    if (int.tryParse(speedDistance.split(' ')[1]) != null) {
                      speed = speedDistance.split(' ')[1];
                    }
                  } catch (e) {}
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mode == 1) {
                    if (speed.isNotEmpty && int.parse(speed) >= 30) {
                      setState(() {
                        speedWarningMessage = 'Tốc độ đang ở mức nguy hiểm';
                      });
                    } else {
                      setState(() {
                        speedWarningMessage = 'Không có cảnh báo nguy hiểm';
                      });
                    }
                  } else {
                    if (speed.isNotEmpty && int.parse(speed) >= 50) {
                      setState(() {
                        speedWarningMessage = 'Tốc độ đang ở mức nguy hiểm';
                      });
                    } else {
                      setState(() {
                        speedWarningMessage = 'Không có cảnh báo nguy hiểm';
                      });
                    }
                  }
                });
                return Text(
                  '${speed.isEmpty ? 0 : speed} km/h',
                  style: const TextStyle(
                    fontSize: 57,
                    height: 64 / 57,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              speedWarningMessage,
              style: const TextStyle(
                fontSize: 16,
                height: 24 / 16,
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            Text(
              'Khoảng cách',
              style: theme.textTheme.displayMedium
                  ?.copyWith(color: theme.colorScheme.onSurface),
            ),
            StreamBuilder(
              stream: _channelDistance.stream,
              builder: (context, snapshot) {
                var distance = '';
                if (snapshot.hasData) {
                  try {
                    final data = snapshot.data as String;
                    final speedDistance =
                        data.substring(data.length - 7, data.length);
                    if (int.tryParse(speedDistance.split(' ')[0]) != null) {
                      distance = speedDistance.split(' ')[0];
                    }
                  } catch (e) {}
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mode == 1) {
                    if (distance.isNotEmpty && int.parse(distance) < 20) {
                      setState(() {
                        distanceWarningMessage = 'Khoảng cách nguy hiểm';
                      });
                    } else {
                      setState(() {
                        distanceWarningMessage = 'Không có cảnh báo nguy hiểm';
                      });
                    }
                  } else {
                    if (distance.isNotEmpty && int.parse(distance) < 30) {
                      setState(() {
                        distanceWarningMessage = 'Khoảng cách nguy hiểm';
                      });
                    } else {
                      setState(() {
                        distanceWarningMessage = 'Không có cảnh báo nguy hiểm';
                      });
                    }
                  }
                });
                return Text(
                  '${distance.isEmpty ? 0 : distance} cm',
                  style: const TextStyle(
                    fontSize: 57,
                    height: 64 / 57,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              distanceWarningMessage,
              style: const TextStyle(
                fontSize: 16,
                height: 24 / 16,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Chế độ',
                    style: theme.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: DropdownButtonFormField<int>(
                value: mode,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(
                    value: 1,
                    child: Text('Đường đồ thị'),
                  ),
                  DropdownMenuItem(
                    value: 2,
                    child: Text('Đường cao tốc'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    mode = value ?? 0;
                    log(mode.toString(), name: 'MODE');
                  });
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Center(
              child: ElevatedButton(
                child: const Text('Gọi cấp cứu'),
                onPressed: () {
                  launchUrl(Uri(scheme: 'tel', path: '115'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
