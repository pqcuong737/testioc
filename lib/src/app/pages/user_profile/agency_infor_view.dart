import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile/src/app/pages/user_profile/user_profile_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/repositories/user_profile/user_profile_repository.dart';
import 'package:mobile/src/utility/Dimens.dart';
import 'package:mobile/src/utility/FontSize.dart';
import 'package:mobile/src/utility/Strings.dart';

class AgencyInforView extends View {
  AgencyInforView({Key key}) : super(key: key);

  @override
  AgencyInforViewState createState() => AgencyInforViewState();
}

class AgencyInforViewState
    extends ViewState<AgencyInforView, UserProfileController> {
  AgencyInforViewState()
      : super(UserProfileController(UserProfileRepository()));
  Size _size;
  @override
  Widget buildPage() {
    if (controller.userInfor == null) {
      controller.getUserInfor();
    }
    final user = controller.userInfor?.result?.userGroups.length > 0 ? controller.userInfor?.result?.userGroups[0] : null;
    _size = MediaQuery.of(context).size;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons
                        .keyboard_backspace), //Image.asset(ImagePath.ic_back),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.pop(context);
                    }),
                Padding(
                    padding:
                    EdgeInsets.only(left: Dimens.appBarTitleMarginLeft),
                    child: Text(
                        user?.group.type == 0
                            ? Strings.agentInforTitle
                            : Strings.departmentInfoTitle,
                        style: Theme.of(context).textTheme.title.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: FontSize.appBarTitleSize,
                            color: Colors.white)))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
              height: _size.height,
              color: Colors.grey[100],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 20, 12, 12),
                    child: Row(
                      children: <Widget>[
                        Text(
                          Strings.infor_general,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _size.width,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          //TODO CODE
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey, width: 0.6),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      user?.group?.type == 0
                                          ? Strings.code_agency
                                          : Strings.code_department,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.code ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //TODO NAME
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey, width: 0.6),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      user?.group?.type == 0
                                          ? Strings.name_agency
                                          : Strings.name_department,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.name ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //TODO CREATED
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey, width: 0.6),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      Strings.created_at_group,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.createdAt != null
                                            ? '${DateTime.parse('${user?.group?.createdAt}').day}/${DateTime.parse('${user?.group?.createdAt}').month}/${DateTime.parse('${user?.group?.createdAt}').year}'
                                            : '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //TODO PHONE
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.grey, width: 0.6),
                                  )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      user?.group?.type == 0
                                          ? Strings.phone_agency
                                          : Strings.phone_department,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.phone ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          //TODO ADDRESS
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
//                          decoration: BoxDecoration(
//                              border: Border(
//                            bottom: BorderSide(color: Colors.grey, width: 0.6),
//                          )),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      user?.group?.type == 0
                                          ? Strings.address_agency
                                          : Strings.address_department,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.address ?? '---',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(fontSize: 14.0),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    width: _size.width,
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          //TODO STATUS
                          Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                            child: Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      Strings.status,
                                      style: TextStyle(fontSize: 14.0),
                                    ),
                                  ),
                                  Container(
                                    constraints: BoxConstraints(
                                        minWidth: 100, maxWidth: 210),
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Text(
                                        user?.group?.active
                                            ? Strings.active
                                            : Strings.deactive,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            color: user?.group?.active
                                                ? Colors.green
                                                : Colors.red),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }
}
