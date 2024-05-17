

class AppTextFieldErrorsStatus {
  AppTextFieldErrorsStatus._();

  static  status(String errorMessage, String type) {
    if(errorMessage != "" ){
      if (errorMessage.toUpperCase().contains(type.toUpperCase())) {
        return errorMessage;
      }
      return null;
    }

    else{
      return null;
    }
  }
}
