import 'package:flutter/material.dart';
import 'package:record_it/db/data_holder.dart';
import 'package:record_it/db/studentDao.dart';
import 'package:record_it/student_detail_model.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({super.key});

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  final StudentDao studentDao = StudentDao();
  List<StudentDetail> studentDetailList = [];
  @override
  void initState() {
    super.initState();
    getStudentDetail();
  }

  void getStudentDetail() async {
    studentDetailList = await studentDao.getStudents();
    if(studentDetailList.isNotEmpty ) {
      setState(() {
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar : AppBar(title: const Text('Detail'),),
        body : Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: studentDetailList.length,
                itemBuilder: (context, i) {
                  return Column (
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            child:  const Text(
                              'Student Name:',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Text(
                              // If listening is active show the recognized words
                                studentDetailList[i].name??""
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: true,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child:  const Text(
                                'Father Name:',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Text(
                              // If listening is active show the recognized words
                                studentDetailList[i].fatherName??""
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Visibility(
                            visible: true,
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              child:  const Text(
                                'Mobile Number:',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16),
                            child: Text(
                              // If listening is active show the recognized words
                                studentDetailList[i].mobileNumber??""
                            ),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(height: 1, color: Colors.grey,),
                      )
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}