part of patients_cubit;

class PatientsState {
  List<Patient> _patients;
  PatientsState(
    this._patients,
  );
  List<Patient> get patients {
    List<Patient> result = (_patients.map((e) {
      return makeCopy(e);
    })).toList();
    return result;
  }
  Patient patient(String id) {
    Patient result = _patients.firstWhere((element) => element.id == id);
    return makeCopy(result);
  }

  Patient makeCopy(Patient e) {
    return new Patient(
        id: e.id,
        firstName: e.firstName,
        lastName: e.lastName,
        hertBeat: e.hertBeat,
        imageUrl: e.imageUrl,
        storedImage: e.storedImage);
  }
}
