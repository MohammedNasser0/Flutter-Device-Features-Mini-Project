import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  String? _recordedFilePath;
  bool _isRecording = false;

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      await _stopRecording();
    } else {
      await _startRecording();
    }
  }

  Future<void> _startRecording() async {
    final bool hasPermission = await _audioRecorder.hasPermission();

    if (!hasPermission) {
      _showMessage('Microphone permission was denied.');
      return;
    }

    final directory = await getApplicationDocumentsDirectory();

    final String filePath = '${directory.path}/my_recording.m4a';

    await _audioRecorder.start(const RecordConfig(), path: filePath);

    if (!mounted) {
      return;
    }

    setState(() {
      _isRecording = true;
      _recordedFilePath = null;
    });
  }

  Future<void> _stopRecording() async {
    final String? path = await _audioRecorder.stop();

    if (!mounted) {
      return;
    }

    setState(() {
      _isRecording = false;
      _recordedFilePath = path;
    });
  }

  Future<void> _playAudio() async {
    final path = _recordedFilePath;

    if (path == null) {
      return;
    }

    await _audioPlayer.play(DeviceFileSource(path));
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _audioRecorder.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Recorder')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(_isRecording ? Icons.mic : Icons.mic_none, size: 100),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleRecording,
                  icon: Icon(_isRecording ? Icons.stop : Icons.mic),
                  label: Text(_isRecording ? 'Stop Recording' : 'Record Audio'),
                ),
              ),
              if (_recordedFilePath != null) ...[
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _playAudio,
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Play Audio'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
