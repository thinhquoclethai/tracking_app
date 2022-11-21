import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.ip});

  final String ip;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ///
  String speedWarningMessage = 'Không có cảnh báo nguy hiểm';
  String distanceWarningMessage = 'Không có cảnh báo nguy hiểm';
  bool _isPlayerPlaying = false;
  bool _isUserClick = false;

  late final WebSocketChannel _channelSpeed;
  late final AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    _channelSpeed = WebSocketChannel.connect(Uri.parse('ws://${widget.ip}'));
    initAudioSource();
  }

  Future<void> initAudioSource() async {
    await _audioPlayer.setAsset('assets/effect.mp3');
    await _audioPlayer.setLoopMode(LoopMode.all);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
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
      body: Column(
        children: [
          const Spacer(),
          Text(
            'Vận tốc',
            style: theme.textTheme.displayLarge
                ?.copyWith(color: theme.colorScheme.onSurface),
          ),
          const SizedBox(height: 8),
          StreamBuilder(
            stream: _channelSpeed.stream,
            builder: (context, snapshot) {
              var speed = '';
              if (snapshot.hasData) {
                try {
                  final data = snapshot.data as String;
                  final speedDistance =
                      data.substring(data.length - 3, data.length);

                  speed = speedDistance;
                } catch (e) {}
              }

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (speed.isNotEmpty && int.parse(speed) >= 50) {
                  setState(() {
                    speedWarningMessage = 'Tốc độ đang ở mức nguy hiểm';
                  });
                  if (!_isPlayerPlaying && !_isUserClick) {
                    _audioPlayer.play();
                    log('Play');
                    setState(() {
                      _isPlayerPlaying = true;
                    });
                  }
                } else {
                  setState(() {
                    speedWarningMessage = 'Không có cảnh báo nguy hiểm';
                  });
                  if (_isPlayerPlaying) {
                    _audioPlayer.pause();
                    log('pause');

                    setState(() {
                      _isPlayerPlaying = false;
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
            style: TextStyle(
              fontSize: 24,
              height: 32 / 24,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('Gọi cấp cứu'),
                  onPressed: () {
                    launchUrl(Uri(scheme: 'tel', path: '115'));
                  },
                ),
                TextButton(
                  onPressed: () {
                    if (_isPlayerPlaying) {
                      setState(() {
                        _isPlayerPlaying = false;
                        _isUserClick = true;
                      });
                      _audioPlayer.pause();

                      return;
                    }
                    setState(() {
                      _isPlayerPlaying = true;
                      _isUserClick = false;
                    });
                    _audioPlayer.play();
                  },
                  child: Text(
                    _isPlayerPlaying ? 'Dừng cảnh báo' : 'Thử cảnh báo',
                  ),
                )
              ],
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
