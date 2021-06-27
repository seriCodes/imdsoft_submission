import 'package:flutter/material.dart';
import '../constants/routes.dart';
import './screens/screensExports.dart' as pageWidgets; 
import './animations/bouncyScreenChange.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
     switch (routeSettings.name) {
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => pageWidgets.HomePage(),
        );
        break;
      case Routes.patientDetails:
        return BouncyScreenChange(
            widget: pageWidgets.PatientDetails(), routeSettings: routeSettings);
        break;
      case Routes.addPatient:
         return BouncyScreenChange(
             widget: pageWidgets.AddPatient(isSaveEnabled: false),
            routeSettings: routeSettings);
        break; 
      case Routes.patientForm:
        return MaterialPageRoute(
          builder: (_) => pageWidgets.PatientForm(),
          settings: routeSettings,
        );
        break;
      case Routes.imageInput:
        return MaterialPageRoute(
          builder: (_) => pageWidgets.ImageInput(),
          settings: routeSettings,
        );
        break;
      default:
        return null;
    }
  }
}
