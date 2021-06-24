import 'package:first_app/models/patient.dart';
import 'package:flutter/material.dart';
import '../blocs/patients_cubit.dart';
import '../widgets/patientItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage() : super();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Patients'),
        ),
        body: BlocBuilder<PatientsCubit, PatientsState>(
          builder: (context, state) {
            List<Patient> copy = state.patients;
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.patients.length,
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(8),
                        height: 60,
                        color: Colors.blue,
                        child: PatientItem(
                          firstName: copy[index].firstName,
                          lastName: copy[index].lastName,
                          hertBeat: copy[index].hertBeat,
                          id: copy[index].id.toString(),
                          imageUrl: copy[index].imageUrl,
                        )),
                  );
                });
          },
        ));
  }
}
