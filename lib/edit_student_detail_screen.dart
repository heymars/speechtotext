import 'package:flutter/material.dart';
import 'package:record_it/shared_prefs.dart';
import 'package:record_it/student_list_page.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class EditStudentDetailPage extends StatefulWidget {
  const EditStudentDetailPage({super.key, required this.name, required this.fatherName, required this.mobileNumber});
  final String name;
  final String fatherName;
  final String mobileNumber;

  @override
  State<StatefulWidget> createState() {
     return EnterStudentDetailState();
  }
}

class EnterStudentDetailState extends State<EditStudentDetailPage> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  bool _isEnabled = false;
  bool _isAcceptBtnEnabled = false;
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
    nameController.text = widget.name;
    fatherNameController.text = widget.fatherName;
    mobileNumberController.text = widget.mobileNumber;
    _isEnabled = true;
    _isAcceptBtnEnabled = true;
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
            _isAcceptBtnEnabled = true;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                  visible: _isEnabled,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          nameController.text = '';
                          name = '';
                          fatherNameController.text = '';
                          fatherName = '';
                          mobileNumberController.text = '';
                          mobileNumber = '';
                          _isAcceptBtnEnabled = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Re-record All'),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _isAcceptBtnEnabled,
                  child: Container(
                    padding: const EdgeInsets.only(left: 16.0, right: 16),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const StudentListPage()),
                        );
                        // Navigator.pop(context, true);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text('Accept'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column (
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
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: nameController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        onClick('NAME');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.blueAccent, //New
                                  blurRadius: 25.0,
                                )
                              ],
                            ),

                            child: const Icon(Icons.mic, color: Colors.blueAccent,)
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child:  const Text(
                    'Father Name:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
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
                    GestureDetector(
                      onTap: () {
                        onClick('FATHER_NAME');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.blueAccent, //New
                                  blurRadius: 25.0,
                                )
                              ],
                            ),

                            child: const Icon(Icons.mic, color: Colors.blueAccent,)
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  child:  const Text(
                    'Mobile Number:',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
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
                    GestureDetector(
                      onTap: () {
                        onClick('MOBILE');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.blueAccent, //New
                                  blurRadius: 25.0,
                                )
                              ],
                            ),

                            child: const Icon(Icons.mic, color: Colors.blueAccent,)
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
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
    } else {
      _stopListening();
    }
  }
}

