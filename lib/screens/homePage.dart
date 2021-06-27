import 'dart:ffi';

import 'package:first_app/models/patient.dart';
import 'package:flutter/material.dart';
import '../blocs/patients_cubit.dart';
import 'dart:convert';
import '../constants/routes.dart';

import '../widgets/patientItem.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sliver_tools/sliver_tools.dart';

class HomePage extends StatefulWidget {
  const HomePage() : super();

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDataEmitted = false;
//
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      BlocProvider.of<PatientsCubit>(context, listen: false)
          .fetchDataFromDataBase()
          .then((_) {
        setState(() {
          _isDataEmitted = true;
          _isInit = true;
        });
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Patients'),
          actions: [
            IconButton(
                onPressed: () async {
                  return Navigator.of(context).pushNamed(
                    Routes.addPatient,
                  );
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: !_isDataEmitted
            ? Center(child: CircularProgressIndicator())
            : BlocBuilder<PatientsCubit, PatientsState>(
                builder: (context, state) {
                  List<Patient> copy = state.patients;
                  return RefreshIndicator(
                    onRefresh: () async {
                      await _onRefreshLoadData(context);
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverStack(
                                insetOnOverlap: true,
                                children: [
                                  SliverPositioned.fill(
                                    top: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 8,
                                            color: Colors.black26,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  MultiSliver(
                                    children: [
                                      SliverPinnedHeader(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300])),
                                            ),
                                            child: Text("My patients"),
                                          ),
                                        ),
                                      ),
                                      SliverClip(
                                        child: MultiSliver(
                                          children: [
                                            SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) => ClipRRect(
                                                  key: UniqueKey(),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(8),
                                                    height: 60,
                                                    color: Colors.blue,
                                                    child: PatientItem(
                                                      firstName:
                                                          copy[index].firstName,
                                                      lastName:
                                                          copy[index].lastName,
                                                      hertBeat:
                                                          copy[index].hertBeat,
                                                      id: copy[index]
                                                          .id
                                                          .toString(),
                                                      imageUrl:
                                                          copy[index].imageUrl,
                                                    ),
                                                  ),
                                                ),
                                                childCount:
                                                    state.patients.length,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: EdgeInsets.all(10),
                          sliver: MultiSliver(
                            pushPinnedChildren: true,
                            children: [
                              SliverStack(
                                insetOnOverlap: true,
                                children: [
                                  SliverPositioned.fill(
                                    top: 16,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const <BoxShadow>[
                                          BoxShadow(
                                            offset: Offset(0, 4),
                                            blurRadius: 8,
                                            color: Colors.black26,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  MultiSliver(
                                    children: [
                                      SliverPinnedHeader(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            margin:
                                                const EdgeInsets.only(top: 16),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 12),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300])),
                                            ),
                                            child: Text("My patients 2"),
                                          ),
                                        ),
                                      ),
                                      SliverClip(
                                        child: MultiSliver(
                                          children: [
                                            SliverList(
                                              delegate:
                                                  SliverChildBuilderDelegate(
                                                (context, index) => ClipRRect(
                                                  key: UniqueKey(),
                                                  borderRadius:
                                                      BorderRadius.circular(99),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    margin: EdgeInsets.all(8),
                                                    height: 60,
                                                    color: Colors.blue,
                                                    child: PatientItem(
                                                      firstName:
                                                          copy[index].firstName,
                                                      lastName:
                                                          copy[index].lastName,
                                                      hertBeat:
                                                          copy[index].hertBeat,
                                                      id: copy[index]
                                                          .id
                                                          .toString(),
                                                      imageUrl:
                                                          copy[index].imageUrl,
                                                    ),
                                                  ),
                                                ),
                                                childCount:
                                                    state.patients.length,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ));
  }
}

Future<void> _onRefreshLoadData(context) async {
  await BlocProvider.of<PatientsCubit>(context, listen: false)
      .fetchDataFromDataBase();
}
