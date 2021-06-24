import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../constants/routes.dart';
import '../blocs/patients_cubit.dart';
import '../blocs/internt_cubit.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class PatientForm extends StatefulWidget {
  @override
  _PatientFormState createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form_key = GlobalKey<FormState>();
  bool _isInit = false;
  Patient _initValues;
  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (!_isInit) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, Object>;
      _imageUrlController.text = routeArgs["imageUrl"];
    }
    _isInit = true;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlController.text.endsWith(".png") &&
        !_imageUrlController.text.endsWith(".jpg") &&
        !_imageUrlController.text.endsWith(".jpeg") &&
        !_imageUrlController.text.isEmpty &&
        !_imageUrlController.text.startsWith('http')) {
      return;
    }
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlController.dispose();
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() {
    if (_form_key.currentState.validate()) {
      _form_key.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit patient"),
      ),
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetDisconnected) {
            return Center(child: Text("No connection"));
          }
          return BlocBuilder<PatientsCubit, PatientsState>(
            builder: (context, state) {
              Patient copy = state.patient(routeArgs["id"]);
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: _form_key,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Text('Enter Heart beat'),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 7,
                          child: TextFormField(
                            initialValue: copy.hertBeat == null
                                ? ""
                                : copy.hertBeat.toString(),
                            decoration: InputDecoration(
                                labelText: 'Enter heart beat between 0 to 200'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            validator: (String v) => heartbeatValidation(v),
                            onSaved: (String value) {},
                            onFieldSubmitted: (value) {
                              if (heartbeatValidation(value) == null) {
                                BlocProvider.of<PatientsCubit>(context)
                                    .saveHeartBeat(value, copy.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('heartbeat updated in state '),
                                    duration: Duration(milliseconds: 2000),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        Text('Enter image url'),
                        TextFormField(
                          onSaved: (String value) {},
                          keyboardType: TextInputType.url,
                          controller: _imageUrlController,
                          focusNode: _imageUrlFocusNode,
                          validator: (v) => urlValidator(v),
                          onFieldSubmitted: (value) {
                            if (urlValidator(value) == null) {
                              BlocProvider.of<PatientsCubit>(context)
                                  .saveUrlImage(value, copy.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('URL updated in state '),
                                  duration: Duration(milliseconds: 2000),
                                ),
                              );
                            }
                            _saveForm();
                          },
                          textInputAction: TextInputAction.done,
                        ),
                        if (!_imageUrlController.text.isEmpty &&
                            (_imageUrlController.text.startsWith('http')))
                          BlocBuilder<InternetCubit, InternetState>(
                            builder: (context, state) {
                              if (state is InternetDisconnected) {
                                return Text(
                                    "Can't present url image without connection");
                              }
                              return FittedBox(
                                  child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ));
                            },
                          ),
                        TextButton.icon(
                            label: Text("Take a picture page"),
                            icon: const Icon(Icons.camera_front),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                Routes.imageInput,
                                arguments: <String, Object>{
                                  "id": copy.id,
                                },
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String heartbeatValidation(value) {
    int hb;
    try {
      hb = int.parse(value);
    } catch (e) {
      return "Please enter a number";
    }
    if (hb < 200 && hb > -1) {
      return null;
    } else {
      return "Please enter VALID a number";
    }
  }

  String urlValidator(value) {
    if (!value.isEmpty && !value.startsWith('http')) {
      return "please enter valid url";
    }
    if (!value.endsWith(".png") &&
        !value.endsWith(".jpg") &&
        !value.endsWith(".jpeg")) {
      return "please enter png, jpg or jpeg url";
    }
    return null;
  }
}
