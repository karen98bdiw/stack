import 'package:flutter/material.dart';
import 'package:stack/models/company_model.dart' as comp;
import 'package:stack/services/profile_services.dart';
import 'package:stack/utils/contstats.dart';

class CompanyInfoPage extends StatefulWidget {
  final comp.Company company;
  CompanyInfoPage({this.company});

  @override
  _CompanyInfoPageState createState() => _CompanyInfoPageState();
}

class _CompanyInfoPageState extends State<CompanyInfoPage> {
  @override
  void initState() {
    print("${widget.company}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [_appBar(), _listWorkers()],
    );
  }

  Widget _listWorkers() {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.26),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: widget.company.stacks.length,
          itemBuilder: (context, index) {
            return StackCard(
              stack: widget.company.stacks[index],
            );
          }),
    );
  }

  Widget _appBar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: BoxDecoration(color: myBackgroundColor),
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      image: DecorationImage(
                          image: AssetImage("assets/user_photo.jpg"),
                          fit: BoxFit.cover)),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    widget.company?.name ?? "null",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Armenia,Erevan,Abovyan 30",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Dental Clinic",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StackCard extends StatefulWidget {
  final comp.Stack stack;
  StackCard({this.stack});

  @override
  _StackCardState createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> {
  bool isSwitched = false;
  bool value = false;
  TimeOfDay _selectedTime = TimeOfDay.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 1)],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
          border: Border.all(color: Colors.grey, width: 0.5)),
      child: InkWell(
        onTap: () {
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => CompanyInfoPage()));
        },
        child: Row(
          children: [
            Flexible(
              flex: 4,
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(65)),
                        image: DecorationImage(
                            image: AssetImage("assets/user_photo.jpg"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.stack.worker),
                        Container(
                            //width: MediaQuery.of(context).size.width * 0.45,
                            child: Text(widget.stack.description)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(left: 20),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      primary: mainButtonColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(80))),
                    ),
                    child: Text("Join"),
                    onPressed: () {
                      showAlertDialog(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(5),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(65)),
                image: DecorationImage(
                    image: AssetImage("assets/user_photo.jpg"),
                    fit: BoxFit.cover)),
          ),
          Text("My title"),
        ],
      ),
      content: _timePicker(),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<Null> _selectTime(BuildContext context) async {
    TimeOfDay time = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }

  Widget _timePicker() {
    return GestureDetector(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(50))),
        padding: EdgeInsets.only(left: 15, right: 15),
        height: 45,
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Start  ${_selectedTime.hour}:${_selectedTime.minute}",
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
    );
  }
}
