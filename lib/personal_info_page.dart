import 'package:flutter/material.dart';

class InfoDetailPage extends StatelessWidget {
  const InfoDetailPage({super.key, required this.name, required this.fatherName, required this.mobileNumber});
  final String name;
  final String fatherName;
  final String mobileNumber;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Detail'),),
        body: Column (
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
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Container(
                    width: 270,
                    child: Text(
                      // If listening is active show the recognized words
                        name
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                child:  const Text(
                  'Father Name:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: Container(
                    width: 270,
                    child: Text(
                      // If listening is active show the recognized words
                        fatherName
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: true,
              child: Container(
                padding: const EdgeInsets.all(16),
                child:  const Text(
                  'Mobile Number:',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16),
                  child: SizedBox(
                    width: 270,
                    child: Text(
                      // If listening is active show the recognized words
                        mobileNumber
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