import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget({super.key});

  @override
  State<StatefulWidget> createState() {
      return SpeechToTextState();
  }
}

class SpeechToTextState extends State<SpeechToTextWidget> {

  final SpeechToText speech = SpeechToText();
  late SpeechToTextProvider speechProvider;

  @override
  void initState() {
    super.initState();
    speechProvider = SpeechToTextProvider(speech);
    initSpeechState();
  }

  Future<void> initSpeechState() async {
    await speechProvider.initialize();
  }

  String _currentLocaleId = '';

  void _setCurrentLocale(SpeechToTextProvider speechProvider) {
    if (speechProvider.isAvailable && _currentLocaleId.isEmpty) {
      _currentLocaleId = speechProvider.systemLocale?.localeId ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    _setCurrentLocale(speechProvider);
    return ChangeNotifierProvider<SpeechToTextProvider>.value(
        value: speechProvider,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Record Student Details'),),
          body: Column(
            children:  [
              TitleAndValueHolder(title: 'Student Name', titleValue: speechProvider.lastResult?.recognizedWords ?? '',),
              TitleAndValueHolder(title: 'Father Name', titleValue: 'Brijlal',),
              TitleAndValueHolder(title: 'Phone Number', titleValue: '9648954350',),
              ElevatedButton(
                onPressed: !speechProvider.isAvailable || speechProvider.isListening
                    ? null
                    : () => speechProvider.listen(
                    partialResults: true, localeId: _currentLocaleId),
                child: speechProvider.isListening ? const Text('Listening') : const Text('Start'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndValueHolder extends StatelessWidget {
  const TitleAndValueHolder({super.key, required this.title, required this.titleValue});
  final String title;
  final String titleValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('$title:'),
          Container(
            width: 200,
            margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent)
            ),
            child:  Text(titleValue),
          )
        ],
      ),
    );
  }
}