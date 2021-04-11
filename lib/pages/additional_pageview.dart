import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/company_model.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/widgets/helpers.dart';
import 'package:stack/widgets/select_week_day_widget.dart';
import 'package:stack/widgets/inputs.dart';

class AdditionalPageView extends StatefulWidget {
  final PageController controller;
  AdditionalPageView({this.controller});

  @override
  _AdditionalPageViewState createState() => _AdditionalPageViewState();
}

class _AdditionalPageViewState extends State<AdditionalPageView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _workTypeController = TextEditingController();

  DateTime curentTime = DateTime.now();

  File _image;
  ImagePicker _picker;

  var _formState = GlobalKey<FormState>();

  List<Widget> listAnimation = [];
  List<String> workDays;

  String dateTime;

  DateTime _selectedTimeEnd;
  DateTime _selectedTimeStart;

  Company company;

  bool isAnimatedContainerOpen = false;

  void onAddStackClick() {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
      if (workDays != null) {
        if (_selectedTimeEnd != null && _selectedTimeStart != null) {
          company.workDays = workDays;
          company.workDayStartTime = _selectedTimeStart;
          company.workDayEndTime = _selectedTimeEnd;
          print(company.toJson());
          setState(() {
            widget.controller.animateToPage(1,
                duration: Duration(milliseconds: 250),
                curve: Curves.bounceInOut);
          });
        } else {
          showError("Please choos start and end time!");
        }
      } else {
        showError("Please select work days");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedTimeStart = DateTime.now();
    _selectedTimeEnd = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    company = Provider.of<Company>(context);
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(46, 61, 77, 1),
        body: _bodyScreen(),
      ),
    );
  }

  Widget _bodyScreen() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Form(
        key: _formState,
        child: ListView(
          children: [
            _avatarImage(),
            customInput("Copany Name", _nameController, false, (v) {
              company.name = v;
            }, (v) {
              return v.isNotEmpty ? null : "Please write company name!";
            }),
            customInput("Description", _workTypeController, false, (v) {
              company.description = v;
            }, (v) {
              return v.isNotEmpty ? null : "Please write company name!";
            }),
            _selectWorkDay(),
            _selectWorkTime(),
            _applyButton(),
          ],
        ),
      ),
    );
  }

  Widget _applyButton() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        left: 20,
        right: 20,
        top: MediaQuery.of(context).size.height * 0.05,
      ),
      height: 45,
      child: ElevatedButton(
        child: Text(
          "Add Stack",
          style: TextStyle(fontSize: 15),
        ),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
            primary: mainButtonColor),
        onPressed: onAddStackClick,
      ),
    );
  }

  Widget _avatarImage() {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
            radius: 60,
            backgroundColor: Colors.white.withOpacity(0.1),
            child: _image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      _image,
                      width: 110,
                      height: 110,
                      fit: BoxFit.fitHeight,
                    ),
                  )
                : Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(55)),
                    width: 110,
                    height: 110,
                    child: Center(
                        child: Text(
                      "Upload Profile Image",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w100,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    )))),
      ),
    );
  }

  Widget _selectWorkDay() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Select work days from - to",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: WeekDays(
              padding: 0,
              selectedDayTextColor: Colors.white,
              unSelectedDayTextColor: Colors.white,
              daysFillColor: Colors.pink,
              backgroundColor: null,
              border: false,
              boxDecoration: BoxDecoration(),
              onSelect: (List<String> values) {
                setState(() {
                  workDays = values;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<Null> _selectTimeStart(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTimeStart),
    );

    if (time != null) {
      setState(() {
        _selectedTimeStart = DateTime(curentTime.year, curentTime.month,
            curentTime.day, time.hour, time.minute);
      });
    }
  }

  Future<Null> _selectTimeEnd(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedTimeEnd),
    );

    if (time != null) {
      setState(() {
        _selectedTimeEnd = DateTime(curentTime.year, curentTime.month,
            curentTime.day, time.hour, time.minute);
      });
    }
  }

  Widget _selectWorkTime() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 5, bottom: 10),
              child: Text(
                "Select work Time",
                style: TextStyle(fontSize: 15, color: Colors.white),
              )),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectTimeStart(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 45,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start  ${_selectedTimeStart.hour}:${_selectedTimeStart.minute}",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectTimeEnd(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    padding: EdgeInsets.only(left: 15, right: 15),
                    height: 45,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "End  ${_selectedTimeEnd.hour}:${_selectedTimeEnd.minute}",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        Icon(
                          Icons.schedule,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _imgFromCamera(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  _imgFromGallery(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source, imageQuality: 50);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery(ImageSource.gallery);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera(ImageSource.camera);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
