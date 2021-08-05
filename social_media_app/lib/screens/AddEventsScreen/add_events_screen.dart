import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_media_app/constants.dart';
import 'package:social_media_app/models/eventType.dart';
import 'package:social_media_app/providers/api.dart';
import 'package:social_media_app/widgets/Registration/pill_toggle_button.dart';
import 'package:social_media_app/widgets/add_post_modal_sheet.dart';

class AddEventsScreen extends StatefulWidget {
  static const routeName = '/AddEventsScreen';
  const AddEventsScreen({Key key}) : super(key: key);

  @override
  _AddEventsScreenState createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  final formKey = GlobalKey<FormState>();

  String title;
  DateTime date;
  String formattedDate;
  TimeOfDay time;
  String link;
  String contactNo;
  String description;
  XFile image;
  Future futureTags;
  EventType selectedEventType;

  void setImage(XFile _selectedImage) => image = _selectedImage;

  @override
  void initState() {
    super.initState();
    futureTags = Api.getEventTypes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Create new event'),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    buildEventName(),
                    SizedBox(height: 20),
                    buildDateTimePicker(),
                    SizedBox(height: 20),
                    buildLink(),
                    SizedBox(height: 20),
                    buildContactNo(),
                    SizedBox(height: 20),
                    buildDescription(),
                    SizedBox(height: 20),
                    ImagePickerHelper(
                      image,
                      setImage,
                      imageWidth: 0.9,
                      imageHeight: 0.3,
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Text(
                        'Event Types',
                        style: kSubtitleTextStyle,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildTags(),
                    SizedBox(height: 20),
                    buildSubmitButton(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void dateTimePicker() async {
    final DateFormat dateFormat = DateFormat('yyyy/MM/dd HH:mm:ss');

    DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 2),
    );

    if (datePicked == null) return;

    TimeOfDay timePicked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 0, minute: 0),
    );
    if (timePicked == null) return;

    setState(() {
      date = DateTime(
        datePicked.year,
        datePicked.month,
        datePicked.day,
        timePicked.hour,
        timePicked.minute,
      );
      formattedDate = dateFormat.format(date);
      print(formattedDate);
    });
  }

  void saveForm() async {
    final isValid = formKey.currentState.validate();

    if (date == null || image == null) {
      Fluttertoast.showToast(
          msg: date == null ? 'date not selected' : 'image not selected');
      return;
    }

    if (isValid) {
      formKey.currentState.save();
      Fluttertoast.showToast(msg: 'Posting...');
      await Api.postEvent(
          title: title,
          time: formattedDate,
          descritpion: description,
          contact: contactNo,
          link: link,
          eventType: selectedEventType?.id,
          image: image);
      Navigator.of(context).pop();
    }
  }

  Widget buildEventName() => TextFormField(
        validator: (String value) =>
            value.isEmpty ? 'Name cannot be empty' : null,
        decoration: InputDecoration(
          labelText: 'Event Name',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        onSaved: (value) => setState(() => title = value),
      );

  Widget buildDateTimePicker() => Row(
        children: [
          Expanded(
            child: Container(
              height: 60,
              padding: const EdgeInsets.only(left: 12),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    date == null
                        ? 'No date selected'
                        : 'selectd date : ${DateFormat.yMMMd().add_jm().format(date)}',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
            onPressed: dateTimePicker,
            child: SizedBox(
                height: 60,
                child: Icon(
                  MdiIcons.calendarMonthOutline,
                )),
            // label: Text('Choose date'),
          ),
        ],
      );

  Widget buildLink() => TextFormField(
        validator: (value) {
          if (value.isEmpty) return 'Empty Link';
          if (!Uri.parse(value).isAbsolute) return 'Invalid Link';
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Registration Link',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.url,
        onSaved: (value) => setState(() => link = value),
      );

  Widget buildContactNo() => TextFormField(
        validator: (String value) {
          String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
          RegExp regExp = new RegExp(pattern);
          if (value.length == 0) {
            return 'Please enter mobile number';
          } else if (!regExp.hasMatch(value)) {
            return 'Please enter valid mobile number';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: 'Contact Number',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        onSaved: (value) => setState(() => contactNo = value),
      );

  Widget buildDescription() => TextFormField(
        validator: (String value) =>
            value.trim().isEmpty ? 'Please enter description ' : null,
        decoration: InputDecoration(
          hintText: 'Describe your event ...',
          labelText: 'Descritpion',
          alignLabelWithHint: true,
          border: OutlineInputBorder(),
        ),
        maxLines: 10,
        keyboardType: TextInputType.multiline,
        onSaved: (value) => setState(() => description = value),
      );

  Widget buildTags() => FutureBuilder(
      future: futureTags,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return Wrap(
            children: snapshot.data.map<Widget>((event) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                child: TextButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          side: BorderSide(
                              color:
                                  (selectedEventType?.id == event?.id ?? false)
                                      ? kPrimaryColor
                                      : Colors.black)))),
                  onPressed: () {
                    setState(() {
                      selectedEventType = event;
                    });
                  },
                  child: Text(
                    event.name,
                    style: TextStyle(
                      fontFamily: 'poppins',
                      fontSize: 13,
                      color: (selectedEventType?.id == event?.id ?? false)
                          ? kPrimaryColor
                          : Colors.black,
                    ),
                  ),
                ),
              );
            }).toList(),
            // children: [
            //   ToggleButtons(
            //     borderRadius: BorderRadius.circular(50),
            //     children: snapshot.data.map<Widget>((skill) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Container(
            //           margin: EdgeInsets.all(5),
            //           decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(50),
            //           ),
            //           child: Text(skill.name),
            //         ),
            //       );
            //     }).toList(),
            //     isSelected: [true, false, false],
            //   ),
            // ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      });

  Widget buildSubmitButton() => Ink(
        width: double.infinity,
        height: 38,
        decoration: BoxDecoration(
          gradient: kButtonLinearGradient,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: saveForm,
          child: Text(
            'Post Event',
            textAlign: TextAlign.center,
            style: kSubtitleTextStyle.copyWith(color: Colors.white),
          ),
          style: TextButton.styleFrom(
            primary: Colors.white,
          ),
        ),
      );
}
