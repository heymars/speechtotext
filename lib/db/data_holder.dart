import 'package:record_it/student_detail_model.dart';

class DataHolder {
  DataHolder._privateConstructor();

  static final DataHolder _instance = DataHolder._privateConstructor();

  factory DataHolder() {
    return _instance;
  }

  final List<StudentDetail> _studentList = <StudentDetail>[];
  final List<ClassDetail> _classDetail = <ClassDetail>[];

  set setStudentList(StudentDetail studentDetail) {
     _studentList.add(studentDetail);
  }

  List<StudentDetail> get getStudentList => _studentList;

  set setClassWithStudentList(ClassDetail classDetail) {
    _classDetail.add(classDetail);
  }

  List<ClassDetail> get getClassList => _classDetail;

}