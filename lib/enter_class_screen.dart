import 'package:flutter/material.dart';
import 'package:record_it/enter_details_screen.dart';
import 'package:record_it/shared_prefs.dart';


class EnterClass extends StatelessWidget {
  const EnterClass({super.key});

  @override
  Widget build(BuildContext context) {
    return const EnterClassPage();
  }
}

class EnterClassPage extends StatefulWidget {

  const EnterClassPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return EnterClassState();
  }
}

class EnterClassState extends State<EnterClassPage> {
  @override
  void initState() {
    super.initState();
  }
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Class Detail'),),
        body: Stack(
          children: [
             Align(
               alignment: Alignment.bottomCenter,
               child: Padding(
                 padding: const EdgeInsets.all(16.0),
                 child: SizedBox(
                   height: 42,
                   width: double.infinity,
                   child: ElevatedButton(
                     onPressed: () {
                       if(nameController.value.text.isNotEmpty) {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => const EnterDetailPage()),
                         );
                       } else {
                         const snackBar = SnackBar(
                           content: Text('Please enter class name'),
                           backgroundColor: (Colors.black12),
                          duration: Duration(seconds: 2),
                         );
                         ScaffoldMessenger.of(context).showSnackBar(snackBar);
                       }
                     },
                     child: const Text('Start'),
                   ),
                 ),
               ),
             ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children:  const [
                    Padding(
                      padding: EdgeInsets.only(top: 50.0,left: 16, right: 16, bottom: 8),
                      child: Text('Enter Class Detail:'),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Class Name:',
                      hintText: 'Enter Class Name',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}