import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/screens/Registration/registration_screen.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class Step3 extends StatefulWidget {
  Function primaryButtonOnPressed;
  Function onBackButonPressed;
  Function(String) onBioChanged;
  String bioValue = '';
  int bioMax;
  Function(String) onSkillAdded;
  Function(String) onSkillRemoved;
  Step3(
      {this.onBackButonPressed,
      this.primaryButtonOnPressed,
      this.bioValue,
      this.bioMax = 100,
      this.onBioChanged,
      this.onSkillAdded,
      this.onSkillRemoved});

  @override
  _Step3State createState() => _Step3State();
}

class _Step3State extends State<Step3> {
  List<String> skills = [];

  @override
  Widget build(BuildContext context) {
    return RegistrationScreen(
      screenMetaData: RegistrationStepTop(
        header: "Let’s add your Bio!",
        step: 3,
      ),
      screenForm: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              LabelledTextField(
                labelText: 'Bio',
                inputType: TextInputType.multiline,
                maxLines: 5,
                maxLength: widget.bioMax,
                onChanged: (value) {
                  if (value.length <= widget.bioMax) {
                    widget.onBioChanged != null
                        ? widget.onBioChanged(value)
                        : '';
                    setState(() {
                      widget.bioValue = value;
                    });
                  }
                },
                value: widget.bioValue,
              ),
              FutureBuilder(
                  future: Api.getSkills(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return SpinKitCircle(
                        color: kPrimaryColor,
                      );
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Skills',
                          style: TextStyle(
                              fontFamily: 'poppins',
                              fontWeight: FontWeight.w800),
                        ),
                        Wrap(
                          children: snapshot.data.map<Widget>((skill) {
                            return PillToggleButton(
                                text: skill.name,
                                onPressed: (value) {
                                  if (value) {
                                    skills.add(skill.id);
                                    widget.onSkillAdded != null
                                        ? widget.onSkillAdded(skill.id)
                                        : '';
                                  } else {
                                    skills.remove(skill.id);
                                    widget.onSkillRemoved != null
                                        ? widget.onSkillRemoved(skill.id)
                                        : '';
                                  }
                                });
                          }).toList(),
                        )
                      ],
                    );
                  })
            ],
          ),
        ),
      ),
      primaryActionButtonText: "Finish",
      primaryButtonOnPressed: () {
        if(widget.bioValue==null|| widget.bioValue.trim().length<3){
          Fluttertoast.showToast(msg: 'Oops! Bio must be between 3 and 100 characters long');
          return;
        }
        widget.primaryButtonOnPressed != null
            ? widget.primaryButtonOnPressed()
            : '';
        Navigator.of(context).pop({'bio':widget.bioValue, 'skills':skills});
      },
      topElementStackBottomPositioning: 50,
    );
  }
}
