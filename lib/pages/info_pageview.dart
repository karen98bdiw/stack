import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:provider/provider.dart';
import 'package:stack/models/stacks.dart';
import 'package:stack/pages/home_page.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/utils/contstats.dart';
import 'package:stack/widgets/inputs.dart';
import 'package:stack/widgets/stack_card.dart';

import 'package:stack/models/company_model.dart' as comp;

class InfoPageView extends StatefulWidget {
  InfoPageView({Key key}) : super(key: key);

  @override
  _InfoPageViewState createState() => _InfoPageViewState();
}

List<Widget> listAnimation = [];

double _heightAnimation = 50;
bool isAnimatedContainerOpen = false;
int currentIndex = 0;

class _InfoPageViewState extends State<InfoPageView> {
  var _workerNameController = TextEditingController();
  var _descriptionController = TextEditingController();

  comp.Company company;

  @override
  Widget build(BuildContext context) {
    company = Provider.of<comp.Company>(context);
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: myBackgroundColor,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: Column(
                  children: [
                    DropDounInfo(
                      onDelete: () {
                        setState(() {});
                      },
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      height: 250,
                      child: ListView.builder(
                        itemBuilder: (c, i) {
                          return StackCard(
                            description: company.stacks[i].description,
                            name: company.stacks[i].worker,
                          );
                        },
                        itemCount: company.stacks.length,
                      ),
                    ),
                    _createStreamButton()
                  ],
                ),
              ),
            ),
          )),
    );
  }

  Widget _createStreamButton() {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50))),
      child: ElevatedButton(
        child: Text(
          "Add Stack",
          style: TextStyle(fontSize: 15),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          primary: mainButtonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
        ),
        onPressed: () {
          CompanyServices().addCompany(company);
        },
      ),
    );
  }
}

class DropDounInfo extends StatefulWidget {
  final Function onDelete;
  DropDounInfo({this.onDelete});

  @override
  _DropDounInfoState createState() => _DropDounInfoState();
}

class _DropDounInfoState extends State<DropDounInfo> {
  String _stackName;
  String _stackDescription;

  comp.Company company;

  void onStackApply() {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();

      comp.Stack stack = comp.Stack(
        id: company.stacks.length.toString(),
        worker: _stackName,
        description: _stackDescription,
      );

      company.addStack(stack: stack);
    }
  }

  var _formState = GlobalKey<FormState>();
  int index = currentIndex;
  @override
  Widget build(BuildContext context) {
    company = Provider.of<comp.Company>(context);

    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Form(
        key: _formState,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "Fill Stack",
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
            ),
            customInput("Worker name", TextEditingController(), false, (v) {
              _stackName = v;
            }, (v) => v.isEmpty ? "Please write stack name" : null),
            customInput("Description", TextEditingController(), false, (v) {
              _stackDescription = v;
            }, (v) => v.isEmpty ? "Please write description" : null),
            _applyStackButton()
          ],
        ),
      ),
    );
  }

  Widget _applyStackButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 45,
      child: ElevatedButton(
          child: Text(
            "Apply Stack",
            style: TextStyle(fontSize: 15),
          ),
          style: ElevatedButton.styleFrom(
            primary: mainButtonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50))),
          ),
          onPressed: onStackApply),
    );
  }
}
