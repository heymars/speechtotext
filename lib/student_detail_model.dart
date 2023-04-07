class ClassDetail {
  ClassDetail({this.className, this.studentList});
  String? className;
  List<StudentDetail>? studentList;
}

class StudentDetail {
  StudentDetail({
      this.className,
      this.name,
      this.fatherName,
      this.mobileNumber,});

  StudentDetail.fromJson(dynamic json) {

    name = json['className'];
    name = json['name'];
    fatherName = json['fatherName'];
    mobileNumber = json['mobileNumber'];
  }
  String? className;
  String? name;
  String? fatherName;
  String? mobileNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['className'] = className;
    map['name'] = name;
    map['fatherName'] = fatherName;
    map['mobileNumber'] = mobileNumber;
    return map;
  }

}