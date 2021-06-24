library patients_cubit;

import 'package:bloc/bloc.dart';

import '../models/patient.dart';
import '../dummy_data.dart';

part 'patients_state.dart';

class PatientsCubit extends Cubit<PatientsState> {
  PatientsCubit() : super(PatientsState(DUMMY_PATIENTS));

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
}
