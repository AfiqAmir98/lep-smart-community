class LogInWithEmailPasswordFailure {
  final String message;

  const LogInWithEmailPasswordFailure([this.message = "Unknown error occur."]);

  factory LogInWithEmailPasswordFailure.code(String code){
    switch(code){
      case 'invalid-email':
        return const LogInWithEmailPasswordFailure('Email is not valid or bad format.');
      case 'user-disabled':
        return const LogInWithEmailPasswordFailure('This user have been disabled. Please contact support for help.');
      default:
        return LogInWithEmailPasswordFailure();
    }
  }
}