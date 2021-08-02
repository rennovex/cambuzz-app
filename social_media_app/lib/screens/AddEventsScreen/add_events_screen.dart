import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AddEventsScreen extends StatefulWidget {
  static const routeName = '/AddEventsScreen';
  const AddEventsScreen({Key key}) : super(key: key);

  @override
  _AddEventsScreenState createState() => _AddEventsScreenState();
}

class _AddEventsScreenState extends State<AddEventsScreen> {
  String eventName;
  DateTime dateTime;
  String link;
  String contactNo;
  String description;

  void datePicker() async {
    var datePicked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2021),
        lastDate: DateTime.now());

    if (datePicked == null) return;
    setState(() {
      dateTime = datePicked;
    });
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
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildEventName(),
                    SizedBox(
                      height: 20,
                    ),
                    buildDatePicker(),
                    SizedBox(
                      height: 20,
                    ),
                    buildLink(),
                    SizedBox(height: 20),
                    buildContactNo(),
                    SizedBox(height: 20),
                    buildDescription(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEventName() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Event Name',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.name,
        onSaved: (value) => setState(() => eventName = value),
      );

  Widget buildDatePicker() => Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(border: Border.all()),
              child: Text(dateTime == null
                  ? 'No date selected'
                  : 'selectd date : ${DateFormat.yMMMd().format(dateTime)}'),
            ),
          ),
          ElevatedButton(
            onPressed: datePicker,
            child: Icon(MdiIcons.calendarMonthOutline),
            // label: Text('Choose date'),
          ),
        ],
      );

  Widget buildLink() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Registration Link',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.url,
        onSaved: (value) => setState(() => link = value),
      );
  Widget buildContactNo() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Contact Number',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.phone,
        onSaved: (value) => setState(() => contactNo = value),
      );

  Widget buildDescription() => TextFormField(
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
}
