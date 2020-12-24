import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/profile/profile_controller.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/Strings.dart';

class ShowDialogSearch extends StatefulWidget {
  Map<String, dynamic> objectSearch;
  ProfileController controller;
  ShowDialogSearch({Key key, this.objectSearch, this.controller})
      : super(key: key);

  @override
  _ShowDialogSearchState createState() => _ShowDialogSearchState();
}

class _ShowDialogSearchState extends State<ShowDialogSearch> {
  final GlobalKey<FormState> _formKeyDialog = new GlobalKey<FormState>();
  var statusProfile;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.objectSearch['status'] != null) {
      statusProfile = widget.objectSearch['status'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          height: 500.0,
          width: 300.0,
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(12),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.blue),
                child: Text(
                  Strings.advanced_search,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                  height: 400,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 5),
                    child: Form(
                        key: _formKeyDialog,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //! Input search contract Number
                              Text(
                                Strings.car_contract_number,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              TextFormField(
                                initialValue:
                                    widget.objectSearch['contractNumber'] !=
                                            null
                                        ? widget.objectSearch['contractNumber']
                                        : '',
                                onChanged: (String value) {
                                  widget.objectSearch['contractNumber'] = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: Strings.hint_car_contract_number,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              //! Input search license plates
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                Strings.license_plates,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              TextFormField(
                                initialValue:
                                    widget.objectSearch['licensePlates'] != null
                                        ? widget.objectSearch['licensePlates']
                                        : '',
                                onChanged: (String value) {
                                  widget.objectSearch['licensePlates'] = value;
                                },
                                decoration: const InputDecoration(
                                  hintText: Strings.hint_license_plates,
                                ),
                                keyboardType: TextInputType.text,
                              ),
                              //! Radio button search status
                              SizedBox(
                                height: 12.0,
                              ),
                              Text(
                                Strings.status,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_PROFILE_DRAFT,
                                        groupValue: statusProfile,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.draft,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value:
                                            Constant.STATUS_PROFILE_COMPLETED,
                                        groupValue: statusProfile,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.completed,
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_PROFILE_APPROVED,
                                        groupValue: statusProfile,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.approved,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      new Radio(
                                        value: Constant.STATUS_REJECTED,
                                        groupValue: statusProfile,
                                        activeColor: Colors.blue,
                                        onChanged: (value) =>
                                            handleRadioValueChange(value),
                                      ),
                                      new Text(
                                        Strings.rejected,
                                        style: new TextStyle(fontSize: 14.0),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ])),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  //? Action delete dialog and clear data search
                  RaisedButton(
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        statusProfile = '';
                      });
                      _formKeyDialog.currentState.reset();
                      widget.objectSearch.clear();
                      widget.controller
                          .getAllProfile(widget.objectSearch, false);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.reset,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  //? Search data
                  RaisedButton(
                    color: Colors.blue,
                    onPressed: () {
                      widget.controller
                          .getAllProfile(widget.objectSearch, false);
                      print("-------xxxxxx---------${widget.objectSearch}");
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.search,
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleRadioValueChange(value) {
    setState(() {
      statusProfile = value;
    });
    widget.objectSearch['status'] = value;
  }
}
