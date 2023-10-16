class UserModel {
  final String? id;
  final String fullName;
  final String icNo;
  final String address;
  final String phoneNo;
  final String role;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.fullName,
    required this.icNo,
    required this.address,
    required this.phoneNo,
    required this.role,
    required this.email,
    required this.password,
  });

  toJson(){
    return{
      "FullName": fullName,
      "ICNumber": icNo,
      "Address": address,
      "Phone":phoneNo,
      "UserRole": role,
      "Email": email,
      "Password": password,
    };
  }
}