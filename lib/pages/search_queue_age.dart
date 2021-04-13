import 'package:flutter/material.dart';
import 'package:stack/models/company_model.dart' as comp;
import 'package:stack/pages/company_info_page.dart';
import 'package:stack/pages/favorite_companies.dart';
import 'package:stack/services/company_services.dart';
import 'package:stack/services/profile_services.dart';

class SearchQueuePage extends StatefulWidget {
  SearchQueuePage({Key key}) : super(key: key);

  @override
  _SearchQueuePageState createState() => _SearchQueuePageState();
}

class _SearchQueuePageState extends State<SearchQueuePage> {
  var _formState = GlobalKey<FormState>();
  TextEditingController _searchController = TextEditingController();
  bool showOnlyFavorite = false;

  void onSave() {
    if (_formState.currentState.validate()) {
      _formState.currentState.save();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(46, 61, 77, 1),
      body: _body(),
    );
  }

  Widget customInput(
      {String hint,
      TextEditingController controller,
      bool obscure,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      IconData preffix}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        cursorColor: Colors.white,
        textAlignVertical: TextAlignVertical.center,
        controller: controller,
        obscureText: obscure,
        style: TextStyle(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          prefixIcon: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Icon(
                preffix,
                color: Colors.white,
              )),
          contentPadding: EdgeInsets.all(13),
          isDense: true,
          filled: true,
          fillColor: Colors.white.withOpacity(0.1),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          focusColor: Colors.white,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          labelStyle: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 18, color: Colors.white),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0))),
        ),
      ),
    );
  }

  Widget _body() {
    return Stack(children: [
      Container(
        child: customInput(
            hint: 'Search',
            obscure: false,
            controller: _searchController,
            preffix: Icons.search),
        margin: EdgeInsets.only(top: 30),
      ),
      Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 90),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showOnlyFavorite = !showOnlyFavorite;
                });
              },
              child: Row(children: [
                Text(
                  "Show only favorite",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ]),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showOnlyFavorite = !showOnlyFavorite;
                });
              },
              child: Row(children: [
                Text(
                  "Show All",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ]),
            ),
          ],
        ),
      ),
      showOnlyFavorite == false
          ? Container(
              child: _listStacks(),
              margin: EdgeInsets.only(top: 110),
            )
          : Container(
              margin: EdgeInsets.only(top: 110),
              child: _listStacksFavorite(),
            )
    ]);
  }

  Widget _listStacks() {
    return ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: ProfileServices().listCompanies.length,
        itemBuilder: (context, index) {
          return StreamsCard(
            company: ProfileServices().listCompanies[index],
          );
        });
  }

  Widget _listStacksFavorite() {
    return ListView.builder(
        //physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: FavoriteCompanies.faforiteList.length,
        itemBuilder: (context, index) {
          return StreamsCard(
            company: ProfileServices().listCompanies[index],
          );
        });
  }
}

class StreamsCard extends StatefulWidget {
  comp.Company company;

  StreamsCard({this.company});

  @override
  _StreamsCardState createState() => _StreamsCardState();
}

class _StreamsCardState extends State<StreamsCard> {
  bool value = false;

  String workDays = "";
  String workTime = "";

  @override
  void initState() {
    widget.company.workDays.forEach((element) {
      workDays += element.toString().substring(0, 3) + ",";
    });
    workTime = widget.company.workDayStartTime.hour.toString() +
        ":" +
        widget.company.workDayStartTime.hour.toString() +
        "-" +
        widget.company.workDayEndTime.hour.toString() +
        ":" +
        widget.company.workDayEndTime.minute.toString();
    super.initState();
  }

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
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CompanyInfoPage(
                    company: widget.company,
                  )));
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
                        Text(widget.company.name),
                        Container(
                          //width: MediaQuery.of(context).size.width * 0.45,
                          child: Text(widget.company.description ?? " "),
                        ),
                        Text(
                          workDays,
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          workTime,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (value == false) {
                      value = !value;
                      FavoriteCompanies.inserWidget(Text("111"));
                      print(FavoriteCompanies.faforiteList);
                    } else {
                      value = !value;
                      FavoriteCompanies.deletWidget();
                      print(FavoriteCompanies.faforiteList);
                    }
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Icon(
                    value ? Icons.star : Icons.star_border_outlined,
                    size: 30,
                    color: value ? Colors.pink : Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
