library patients_cubit;

import 'package:bloc/bloc.dart';

import '../models/patient.dart';
 import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/routes.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
   PatientsCubit() : super( PatientsState( [new Patient(firstName: "",lastName: "",id: "")]));

  Future<void> fetchDataFromDataBase() async {
 
     final url = Uri.parse(Routes.dataBase + Routes.collections["patients"]);
    final result = await http.get(url);
    Map<String, Object> raw = jsonDecode(result.body);
    List<Patient> newList = [];
    for (var k in raw.keys) {
      dynamic pa = raw[k];
      newList.add(new Patient(
        id: k,
        firstName: pa["firstName"],
        lastName: pa["lastName"],
        hertBeat: int.parse(pa["hertBeat"]),
      ));
    }
    emit(PatientsState(newList));
    return new Future((){});
  }

  void saveHeartBeat(String value, String id) {
    List<Patient> newList = state.patients;
    Patient result = newList.firstWhere((element) => element.id == id);

    result.hertBeat = int.parse(value);
    emit(PatientsState(newList));
  }

  void saveUrlImage(String value, String id) {
    List<Patient> newList = state.patients;
    Patient result = newList.firstWhere((element) => element.id == id);
    result.imageUrl = value;
    emit(PatientsState(newList));
  }

  void saveStoredImage(String value, String id) {
    List<Patient> newList = state.patients;
    Patient result = newList.firstWhere((element) => element.id == id);
    result.storedImage = value;
    emit(PatientsState(newList));
  }

  int getItemIndex(String id) {
    int result = state.patients.indexWhere((element) => element.id == id);

    return result;
  }

  Future<String> saveNewPatientToDatabase(
      {String heartBeat, String firstName, String lastName}) async {
    final url = Uri.parse(Routes.dataBase + Routes.collections["patients"]);
    try {
      //  http.Response  result = await http.post(url,
      final result = await http.post(url,
          body: json.encode({
            "firstName": firstName,
            "lastName": lastName,
            "hertBeat": heartBeat.toString(),
            // storedImage
          }));
      if (result.statusCode != 200) {
        throw (result.body);
      }
      final patient = new Patient(
        id: result.body,
        firstName: firstName,
        lastName: lastName,
        hertBeat: int.parse(heartBeat),
        // storedImage
        imageUrl: "",
        storedImage: "",
      );
      List<Patient> newList = state.patients;

      newList.add(patient);
      emit(PatientsState(newList));
    } catch (error) {
      print("error in cubit");
      throw (error);
    }
  }
}
