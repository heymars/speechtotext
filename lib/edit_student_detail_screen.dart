import 'package:flutter/material.dart';
import 'package:record_it/shared_prefs.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'enter_details_screen.dart';

class EditStudentDetailPage extends StatefulWidget {
  const EditStudentDetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
     return EnterDetailState();
  }
}

class EnterDetailState extends State<EnterDetailPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isEnabled = false;
  String _lastWords = '';
  String currentValue = '';
  String name = '';
  String fatherName = '';
  String mobileNumber = '';
  List<String> valueList = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSpeech();
    SharedPreferenceHelper.init();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(listenFor: const Duration(minutes: 1),onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  Future<void> _onSpeechResult(SpeechRecognitionResult result)  async {
    setState(() {
      _lastWords = result.recognizedWords;
      if(currentValue == 'MOBILE') {
        mobileNumber = _lastWords;
        mobileNumberController.text = mobileNumber;
      } else if (currentValue == 'NAME') {
        name = _lastWords;
        nameController.text = name;
      } else if(currentValue == 'FATHER_NAME'){
        fatherName = _lastWords;
        fatherNameController.text = fatherName;
      }
      if(name.isNotEmpty && fatherName.isNotEmpty && mobileNumber.isNotEmpty) {
        Future.delayed(const Duration(milliseconds: 500), () {
          setState(() {
            _isEnabled = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speech Demo'),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: mobileNumber.isEmpty,
                  child: GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueAccent,
                        ),
                        width: double.infinity,
                        child: Center(child: Text(_speechToText.isNotListening ?'Record': 'Listening')),
                      ),
                    ),
                    onLongPressStart: (_) {
                      if(currentValue.isEmpty) {
                        onClick('NAME');
                      } else if(currentValue == 'NAME') {
                        onClick('FATHER_NAME');
                      } else if(currentValue == 'FATHER_NAME'){
                        onClick('MOBILE');
                      }
                    },
                    onLongPressEnd: (_) {
                      setState(() {
                        if(currentValue == 'MOBILE') {
                          mobileNumber = _lastWords;
                        } else if (currentValue == 'NAME') {
                          name = _lastWords;
                        } else if(currentValue == 'FATHER_NAME'){
                          fatherName = _lastWords;
                        }
                        if(name.isNotEmpty && fatherName.isNotEmpty && mobileNumber.isNotEmpty) {
                          Future.delayed(const Duration(milliseconds: 500), () {
                            setState(() {
                              _isEnabled = true;
                            });
                          });
                        }
                        if(_speechToText.isListening) {
                          _stopListening();
                        }
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: mobileNumber.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        int value = SharedPreferenceHelper.getAccessToken() ?? 1;
                        SharedPreferenceHelper.setAccessToken(value + 1 );

                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Accept'),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: mobileNumber.isNotEmpty,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EnterDetailPage()),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Edit'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Column (
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child:  const Text(
                  'Student Name:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                ],
              ),
              Visibility(
                visible: name.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child:  const Text(
                    'Father Name:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Visibility(
                visible: name.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: fatherNameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: fatherName.isNotEmpty,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child:  const Text(
                    'Mobile Number:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Visibility(
                visible: fatherName.isNotEmpty,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: mobileNumberController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed:
      //   // If not yet listening for speech start, otherwise stop
      //   _speechToText.isNotListening ? _startListening : _stopListening,
      //   tooltip: 'Listen',
      //   child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
      // ),
    );
  }

  void onClick(String value) {
    setState(() {
      currentValue = value;
    });
    if(_speechToText.isNotListening) {
      _startListening();
    }
  }
}

