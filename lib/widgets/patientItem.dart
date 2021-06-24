import 'package:flutter/material.dart';
import '../constants/routes.dart';

class PatientItem extends StatelessWidget {
  final String firstName;
  final String lastName;
  final int hertBeat;
  final String id;
  final String imageUrl;

  PatientItem(
      {this.firstName, this.lastName, this.hertBeat, this.id, this.imageUrl});
  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        return Navigator.of(context)
            .pushNamed(Routes.patientDetails, arguments: id);
      },
      behavior: HitTestBehavior.opaque,
      child: Row(key: ValueKey(id), children: [
        Text(
          '${firstName} ${lastName}',
          style: appTheme.textTheme.bodyText1,
        ),
        Spacer(),
        Text(
          '${hertBeat != null ? hertBeat : "No heart beat data"}',
          style: appTheme.textTheme.bodyText2,
        ),
      ]),
    );
  }
}
