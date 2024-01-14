
import 'dart:convert';

EmpResponce empResponceFromJson(String str) => EmpResponce.fromJson(json.decode(str));

String empResponceToJson(EmpResponce data) => json.encode(data.toJson());

class EmpResponce {
  String status;
  List<Employe> data;
  String message;

  EmpResponce({
    required this.status,
    required this.data,
    required this.message,
  });

  factory EmpResponce.fromJson(Map<String, dynamic> json) => EmpResponce(
    status: json["status"],
    data: List<Employe>.from(json["data"].map((x) => Employe.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "message": message,
  };
}

class Employe {
  int id;
  String employeeName;
  int employeeSalary;
  int employeeAge;
  String profileImage;

  Employe({
    required this.id,
    required this.employeeName,
    required this.employeeSalary,
    required this.employeeAge,
    required this.profileImage,
  });

  factory Employe.fromJson(Map<String, dynamic> json) => Employe(
    id: json["id"],
    employeeName: json["employee_name"],
    employeeSalary: json["employee_salary"],
    employeeAge: json["employee_age"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "employee_name": employeeName,
    "employee_salary": employeeSalary,
    "employee_age": employeeAge,
    "profile_image": profileImage,
  };
}
