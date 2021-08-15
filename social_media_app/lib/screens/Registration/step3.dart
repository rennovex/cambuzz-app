import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/registration_widget_element.dart';
import 'package:social_media_app/models/skill.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/Registration/labelled_text_field.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';
import 'package:social_media_app/widgets/Registration/registration_screen_skeleton.dart';
import 'package:social_media_app/widgets/Registration/registration_step_top.dart';

class step3 extends StatelessWidget {
  final Function primaryButtonOnPressed;
  final Function onBackButonPressed;
  final Function(String) onBioChanged;
  final String bioValue;
  final int bioMax;
  final Function(String) onSkillAdded;
  final Function(String) onSkillRemoved;

  step3({
    Key key,
    @required this.onBackButonPressed,
    @required this.primaryButtonOnPressed,
    @required this.onBioChanged,
    this.bioValue = '',
    @required this.bioMax,
    @required this.onSkillAdded,
    @required this.onSkillRemoved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RegistrationScreenSkeleton(
      registrationElement: RegistrationElement(
          topElementStackBottomPositioning: 50,
          topElement: RegistrationStepTop(
            header: "Let’s add your Bio!",
            step: 3,
          ),
          bottomElement: Container(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  LabelledTextField(
                    labelText: 'Bio',
                    inputType: TextInputType.multiline,
                    maxLines: 5,
                    onChanged: onBioChanged,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [Text('${bioValue?.length ?? 0}/$bioMax')],
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
                            SingleChildScrollView(
                              child: Wrap(
                                children: snapshot.data
                                    .map<Widget>((skill) {
                                          return PillToggleButton(
                                              text: skill.name,
                                              onPressed: (value) {
                                                if (value) {
                                                  onSkillAdded(skill.id);
                                                } else {
                                                  onSkillRemoved(skill.id);
                                                }
                                              });
                                        })
                                    .toList(),
                              ),
                            )
                          ],
                        );
                      })
                ],
              ),
            ),
          ),
          primaryButtonText: "Finish",
          primaryButtonOnPressed: primaryButtonOnPressed,
          onBackButonPressed: onBackButonPressed,
          hasBackButton: true),
    );
  }
}
