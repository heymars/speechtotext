import 'package:record_it/student_detail_model.dart';
import 'package:sembast/sembast.dart';

import 'app_database.dart';

class StudentDao {
  late StoreRef _studentStore;
  StudentDao() {
    _studentStore = intMapStoreFactory.store('StudentData');
  }

  Future<Database> get _db async => await AppDatabase.instance.database;

  Future insert(Map<String, dynamic> studentMap) async {
    await _studentStore.add(await _db, studentMap);
  }

  Future<List<StudentDetail>> getStudents() async {
    final records = await _studentStore.find(await _db);
    List<StudentDetail> studentList = [];
    for (var json in records) {
      final data = StudentDetail.fromJson(json.value);
      studentList.add(data);
    }
    return studentList;
  }


  Future<int> deleteAllRecords() async {
    return await _studentStore.delete(await _db);
  }
}