  import 'package:cloud_firestore/cloud_firestore.dart';
  import 'package:firebase_auth/firebase_auth.dart';

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

    factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
      final data = document.data()!;
      return UserModel(
          id: document.id,
          fullName: data["FullName"],
          icNo: data["ICNumber"],
          address: data["Address"],
          phoneNo: data["Phone"],
          role: data["UserRole"],
          email: data["Email"],
          password: data["Password"]
      );
    }
  }