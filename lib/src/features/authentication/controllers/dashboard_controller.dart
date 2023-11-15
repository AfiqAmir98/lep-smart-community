import 'package:get/get.dart';
import 'package:psm_project/src/repository/authentication_repository/authentication_repository.dart';
import 'package:psm_project/src/repository/user_repository.dart';

class DashboardController extends GetxController {
  static DashboardController get instance => Get.find();

  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  RxString userRole = ''.obs; // Observable for user role

  getUserData() {
    final email = _authRepo.firebaseUser.value?.email;
    if (email != null) {
      _userRepo.getUserDetails(email).then((userData) {
        if (userData != null) {
          userRole.value = userData.role; // Assign user role to observable
        }
      });
    } else {
      Get.snackbar("Error", "Login to Continue");
    }
  }
}
