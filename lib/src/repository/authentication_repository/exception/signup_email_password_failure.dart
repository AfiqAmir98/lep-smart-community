class SignUpWithEmailPasswordFailure {
  final String message;

  const SignUpWithEmailPasswordFailure([this.message = "Unknown error occur."]);

  factory SignUpWithEmailPasswordFailure.code(String code){
    switch(code){
      case 'weak-password':
        return const SignUpWithEmailPasswordFailure('Please enter strong password.');
      case 'invalid-email':
        return const SignUpWithEmailPasswordFailure('Email is not valid or bad format.');
      case 'email-already-in-use':
        return const SignUpWithEmailPasswordFailure('An account already exist for that email.');
      case 'operation-not-allowed':
        return const SignUpWithEmailPasswordFailure('Operation not allowed, Please contact support.');
      case 'user-disabled':
        return const SignUpWithEmailPasswordFailure('This user have been disabled. Please contact support for help.');
      default:
        return SignUpWithEmailPasswordFailure();
    }
  }
}