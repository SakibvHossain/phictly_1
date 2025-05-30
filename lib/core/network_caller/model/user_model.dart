class UserModel {
  bool? success;
  String? message;
  UserInfo? result;

  UserModel({this.success, this.message, this.result});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    result = json['result'] != null ? UserInfo.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class UserInfo {
  String? id;
  String? userName;
  String? profileImage;
  String? email;
  String? role;
  String? location;
  String? gender;
  String? customerId;
  String? designation;
  String? about;
  bool? subscriptions;
  String? status;

  UserInfo({
    this.id,
    this.userName,
    this.profileImage,
    this.email,
    this.role,
    this.location,
    this.gender,
    this.customerId,
    this.designation,
    this.about,
    this.subscriptions,
    this.status,
  });

  UserInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['userName'];
    profileImage = json['profileImage'];
    email = json['email'];
    role = json['role'];
    location = json['location'];
    gender = json['gender'];
    customerId = json['customerId'];
    designation = json['designation'];
    about = json['about'];
    subscriptions = json['subscriptions'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userName'] = userName;
    data['profileImage'] = profileImage;
    data['email'] = email;
    data['role'] = role;
    data['location'] = location;
    data['gender'] = gender;
    data['customerId'] = customerId;
    data['designation'] = designation;
    data['about'] = about;
    data['subscriptions'] = subscriptions;
    data['status'] = status;
    return data;
  }
}
