class Constants {
//Authentication Screen --start
  static const String emailAlreadyExists =
      'Email already exist, please try another email.';
  static const String emailNotFound =
      'Email not found in our database. Signup process started.';
  static const String invalidLoginCredentials =
      'Invalid username and password combinations.';
  static const String compleateSignUpProcess =
      "Please enter few more informations to compleate signup process.";
//TextSpan --start
static const String textSpan1="We did not find a match,";
static const String textSpan2="you are now creating a new account.";
static const String textSpan3="if you already have an account please try something different or login with Google.";
//TextSpan --end

//Facebook Login --start
  static const String fbLoginCancelled = "faceBook login cancelled by user.";
  static const String fbFatalError = "facebook fatal error.";
//Facebook Login --end
//Forgot password --start
static const String forgotPwdCheckEmail = "Please check your registered email to reset the password.";
static const String forgotPwdEmailNotFound="We do not recognize this email address.";
static const String forgotPwdEnterDetails ="Please enter registered EMAIL/PHONE/USERNAME to reset Password.";
//Forgot password --end
//Authentication Screen --start

//Setup Screen --start
static const setupBeforeweplaceMsg="Before you place your first wash, let's setup your account";
static const setupBeforeWeStartMsg="Before we start let me introduce myself.";
static const setupYourAssistantMsg="I'm your assistant, give me a try.";
static const setupLetsStartMsg="Let's start by putting a face to that name.";
static const setupLetsSetupMsg="Let's setup your account.";
static const setupPaymentMethod="Payment Method";
static const setupWardrobe ="Wardrobe";

//Setup Screen --end


//regEx constants --start
  static const String regexEmail = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String regexNumber = r"^[-+]?\d*$";
  static const String regexPhone = r"^[-+]?\d*$";
  static const String regexTrimSpaces=r"\s+\b|\b\s";
//regEx constants --end

}
