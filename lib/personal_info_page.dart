import 'package:flutter/material.dart';
import 'package:record_it/db/data_holder.dart';

class InfoDetailPage extends StatelessWidget {
  const InfoDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var classList = DataHolder().getClassList;
    return SafeArea(
      child: Scaffold(
        appBar : AppBar(title: const Text('Detail'),),
        body : Expanded(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: classList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(classList[index].className ?? ''),
                    ),
                    ListView.builder(
                      itemCount: classList[index].studentList?.length,
                      itemBuilder: (context, i) {
                        return Column (
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
                                  child: SizedBox(
                                    width: 270,
                                    child: Text(
                                      // If listening is active show the recognized words
                                        classList[index].studentList![i].name??""
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
                                  child: SizedBox(
                                    width: 270,
                                    child: Text(
                                      // If listening is active show the recognized words
                                        classList[index].studentList![i].fatherName??""
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
                                        classList[index].studentList![i].mobileNumber??""
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}