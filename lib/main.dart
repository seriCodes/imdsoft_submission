import 'package:flutter/material.dart';
import './app_router.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
 import 'package:flutter_bloc/flutter_bloc.dart';
import './blocs/patients_cubit.dart';
import './blocs/internt_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);
// 
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
 providers: [
        BlocProvider<InternetCubit>(
            create: (context) => InternetCubit(connectivity: connectivity)),
        BlocProvider<PatientsCubit>(
          create: (context) => PatientsCubit(),
        ),
      ],      child: MaterialApp(
        title: 'Flutter imdsoft Task',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFFFFFFF),
              fontSize: 21.5,
            ),
            bodyText2: TextStyle(
              color: Colors.indigo,
              fontSize: 17.5,
            ),
          ),
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
