class FormValidators{
  static String heartbeatValidation(String value) {
    print('validator hb');
    int hb;
    try {
      hb = int.parse(value);
    } catch (e) {
      print(e);
      return "Eenter a number";
    }
    if (hb < 200 && hb > -1) {
      return null;
    } else {
      return "Not VALID";
    }
  }
static  String urlValidator(value) {
    print('validator img');
    print(value);
    if (!value.isEmpty && !value.startsWith('http')
        // && !value.startsWith('https')
        ) {
      return "please enter valid url";
    }
    if (!value.endsWith(".png") &&
        !value.endsWith(".jpg") &&
        !value.endsWith(".jpeg")) {
      print('jpg');
      return "please enter png, jpg or jpeg url";
    }
    print("before url null");
    return null;
  }
static  String nameValidator(value) {
    // print('validator img');
    // print(value);
     final validCharacters = RegExp(r'^[a-zA-Z]+$');
     value = value.trim();
    // print("validCharacters.hasMatch(value");
    // print(validCharacters.hasMatch(value));

    if (value.isEmpty || !validCharacters.hasMatch(value) 
        // && !value.startsWith('https')
        ) {
      return "Enter a valid name";
    }
   
     return null;
  }

}