// Model_Class_UserModel
class UserModel {
  int? id;
  int? age;
  String? job;
  String? name;
  String? email;
 String? phoneNumber;

  UserModel(
      {this.id, this.age, this.job, this.name, this.email, this.phoneNumber});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    age = json['Age'];
    job = json['Job'];
    name = json['Name'];
    email = json['Email'];
    phoneNumber = json['PhoneNumber'];
  }
}
