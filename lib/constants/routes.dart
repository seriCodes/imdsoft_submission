class Routes {
  static const String home = '/';
  static const String patientDetails = '/patient-detail';
  static const String patientForm = '/patient-form';
  static const String imageInput = '/image_input_device';
  static const String addPatient = '/add_patient';
  static const String dataBase =
      'https://flutter-study-ceef3-default-rtdb.europe-west1.firebasedatabase.app/';
  static const Map<String, String> collections = {"patients": "patients.json"};
}
