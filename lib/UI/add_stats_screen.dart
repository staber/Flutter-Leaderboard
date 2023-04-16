import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../main.dart';

class AddStatPage extends StatelessWidget {
  AddStatPage({Key? key, required this.player}) : super(key: key);
  final Map<String, dynamic> player;
  int newShots = 0;
  int newRebounds = 0;
  int newWrist = 0;
  bool _submitting = false;
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormBuilderState>();
    newShots = player['shots'];
    newRebounds = player['rebounder_mins'];
    newWrist = player['wrist_roller_reps'];
    _context = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(player['first'] + ' ' + player['last']),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 48),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 15),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'shots',
                      decoration: const InputDecoration(
                        labelText: 'Shots',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onChanged: (val) {
                        if (_formKey.currentState?.fields['shots']
                                ?.validate() ??
                            false) {
                          newShots = newShots + int.parse(val!);
                        }
                        /*setState(() {
                          _ageHasError = !(_formKey.currentState?.fields['age']
                                  ?.validate() ??
                              false);
                        });*/
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(10000),
                      ]),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 30),
                    Text(player['first'] +
                        ' has ' +
                        player['shots'].toString() +
                        ' shots so far, ' +
                        (10000 - player['shots']).toString() +
                        ' shots left to reach 10,000.'),
                    const SizedBox(height: 15),
                    FAProgressBar(
                      currentValue: (100 * player['shots'] / 10000),
                      size: 25,
                      maxValue: 100,
                      changeColorValue: 100,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(25),
                      animatedDuration: const Duration(milliseconds: 1000),
                      direction: Axis.horizontal,
                      formatValueFixed: 2,
                      displayText: '%',
                    ),
                    const SizedBox(height: 30),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'rebounds',
                      decoration: const InputDecoration(
                        labelText: 'Rebounder Minutes',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onChanged: (val) {
                        if (_formKey.currentState?.fields['rebounds']
                                ?.validate() ??
                            false) {
                          newRebounds = newRebounds + int.parse(val!);
                        }
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(4500),
                      ]),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 30),
                    Text(player['first'] +
                        ' has ' +
                        player['rebounder_mins'].toString() +
                        ' rebounder minutes so far, ' +
                        (4500 - player['rebounder_mins']).toString() +
                        ' minutes left to reach 4,500 (75 hours).'),
                    const SizedBox(height: 15),
                    FAProgressBar(
                      currentValue: (100 * player['rebounder_mins'] / 4500),
                      size: 25,
                      maxValue: 100,
                      changeColorValue: 100,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(25),
                      animatedDuration: const Duration(milliseconds: 1000),
                      direction: Axis.horizontal,
                      formatValueFixed: 2,
                      displayText: '%',
                    ),
                    const SizedBox(height: 30),
                    FormBuilderTextField(
                      autovalidateMode: AutovalidateMode.always,
                      name: 'wrist',
                      decoration: const InputDecoration(
                        labelText: 'Wrist Roller Reps',
                        contentPadding: EdgeInsets.all(8),
                      ),
                      onChanged: (val) {
                        if (_formKey.currentState?.fields['wrist']
                                ?.validate() ??
                            false) {
                          newWrist = newWrist + int.parse(val!);
                        }
                      },
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(1000),
                      ]),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 30),
                    Text(player['first'] +
                        ' has ' +
                        player['wrist_roller_reps'].toString() +
                        ' wrist roller reps so far, ' +
                        (1000 - player['wrist_roller_reps']).toString() +
                        ' reps left to reach 1,000.'),
                    const SizedBox(height: 15),
                    FAProgressBar(
                      currentValue: (100 * player['wrist_roller_reps'] / 1000),
                      size: 25,
                      maxValue: 100,
                      changeColorValue: 100,
                      backgroundColor: Colors.grey.shade300,
                      progressColor: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(25),
                      animatedDuration: const Duration(milliseconds: 1000),
                      direction: Axis.horizontal,
                      formatValueFixed: 2,
                      displayText: '%',
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.deepOrange,
                            minimumSize: const Size(88, 48),
                            padding: const EdgeInsets.all(16.0),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                            ),
                          ),
                          icon: _submitting
                              ? (const CircularProgressIndicator(
                                  color: Colors.white,
                                ))
                              : const Icon(Icons.upload),
                          label: const Text('Add Stats'),
                          onPressed: () {
                            _submit();
                            //Navigator.pop(context);
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    _submitting = true;
    await supabase.from('players').update({
      'shots': newShots,
      'rebounder_mins': newRebounds,
      'wrist_roller_reps': newWrist
    }).match({'id': player['id']}).whenComplete(() => _return());
  }

  void _return() {
    Navigator.pop(_context, true);
  }
}
