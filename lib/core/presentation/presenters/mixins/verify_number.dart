mixin VerifyNumber {
  String verifyNumber(int numberString){
    if(numberString < 10){
      return "0${numberString}";
    }
    return "${numberString}";
  }
}