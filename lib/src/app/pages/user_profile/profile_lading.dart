import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mobile/src/app/pages/splash/splash_view.dart';
import 'package:mobile/src/app/pages/technical_support/technical_support.view.dart';
import 'package:mobile/src/app/pages/user_profile/agency_infor_view.dart';
import 'package:mobile/src/app/pages/user_profile/change_pass_view.dart';
import 'package:mobile/src/app/pages/user_profile/invidual_infor_view.dart';
import 'package:mobile/src/app/pages/user_profile/user_profile_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/repositories/user_profile/user_profile_repository.dart';
import 'package:mobile/src/route.dart';
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';

class ProfileLanding extends View {
//  final UserInfor userInfor;

  @override
  ProfileLandingState createState() => ProfileLandingState();
}

class ProfileLandingState
    extends ViewState<ProfileLanding, UserProfileController> {
  Size _size;
  double marginLeft = 25;
  double dividerMargin = 65;

  ProfileLandingState() : super(UserProfileController(UserProfileRepository()));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildPage() {
    if (controller.userInfor == null) {
      controller.getUserInfor();
    }
    var infoGroupOfUser = controller.userInfor?.result?.userGroups?.length > 0
        ? controller.userInfor?.result?.userGroups[0]
        : null;
    _size = MediaQuery.of(context).size;
    return MaterialApp(
      title: '',
      home: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[600],
          title: Container(
            child: Row(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons
                        .keyboard_backspace), //Image.asset(ImagePath.ic_back),
                    iconSize: 30.0,
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Color(0xffffff),
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: _size.width / 2.4,
                        width: double.infinity,
                        color: Colors.blue[600],
                        child:
                            buildHeader(controller.userInfor, infoGroupOfUser),
                      ),
                      buildRow(ImagePath.ic_personal_avatar,
                          Strings.invidualInfor, 0, marginLeft, false),
                      infoGroupOfUser != null
                          ? buildRow(
                              ImagePath.ic_agent_infor,
                              infoGroupOfUser?.group?.type == 0
                                  ? Strings.agentInforTitle
                                  : Strings.departmentInfoTitle,
                              1,
                              marginLeft,
                              false)
                          : SizedBox(),
//                      buildRow(ImagePath.ic_agent_infor,
//                          Strings.agentInforTitle, 1, marginLeft, false),
                      buildRow(ImagePath.ic_change_pass,
                          Strings.changePassWordTitle, 2, marginLeft, true),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            buildRowSupport(ImagePath.img_support, Strings.tech, marginLeft),
//            Expanded(
//                child: Container(
//              color: Color(0xf9f9f9),
//            ))
          ],
        ),
        bottomNavigationBar: Container(
          height: 60,
          color: Colors.white,
          child: Stack(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              Container(
                height: double.infinity,
                child: InkWell(
                  onTap: () {
                    progressSubjectAdd.add(true);
                    LocalStorageService.saveToken("");
                    NavigatorUtilities.pushAndRemoveUntil(
                        context, SplashScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.only(left: marginLeft),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          ImagePath.ic_exit,
                          width: 25,
                          height: 25,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: marginLeft / 2),
                          child: Text(Strings.logout,
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.title.copyWith(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Colors.black)),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHeader(UserInfor userInfor, infoGroupOfUser) {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: userInfor?.result?.avatarUrl != null
              ? Image.network(
                  userInfor.result.avatarUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ImagePath.sample_avatar,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            userInfor != null ? userInfor.result.fullName : "Nhân viên sale",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            userInfor != null ? genderRoleString(userInfor.result.role) : "---",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: Colors.white),
          ),
        ),
        //TODO SHOW WHEN USER NOT GROUP
        Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            infoGroupOfUser != null ? "" : Strings.user_not_group,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.title.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 15,
                color: Colors.yellow),
          ),
        ),
      ],
    );
  }

  Column buildRowSupport(String iconPath, String title, double margin) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TechnicalPage(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Colors.grey, width: 0.2),
                    bottom: BorderSide(color: Colors.grey, width: 0.3))),
            padding: EdgeInsets.only(top: margin, left: margin, bottom: margin),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  iconPath,
                  width: 25,
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: marginLeft),
                  child: Image.asset(
                    ImagePath.ic_arr_2_details,
                    width: 10,
                    height: 10,
                  ),
                )
              ],
            ),
          ),
        ),
//        Padding(
//          padding: EdgeInsets.only(left: isItemEnd ? 0 : dividerMargin),
//          child: Container(
//            height: 1,
//            width: double.maxFinite,
//            color: Colors.black12,
//          ),
//        )
      ],
    );
  }

  Column buildRow(
      String iconPath, String title, int i, double margin, bool isItemEnd) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (i == 0) {
//              final param = 'go_to_invidual_view';
//              Navigator.pushNamed(
//                  context, '${NavigationName.INVIDUAL_INFOR}${param}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InviDualInforView(),
                ),
              );
            } else if (i == 1) {
//              final param = 'go_to_agency_view';
//              Navigator.pushNamed(
//                  context, '${NavigationName.AGENCY_INFOR}${param}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AgencyInforView(),
                  ));
            } else {
//              final param = 'go_to_change_pass_view';
//              Navigator.pushNamed(
//                  context, '${NavigationName.CHANGE_PASS}${param}');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassView(),
                  ));
            }
          },
          child: Container(
            color: Colors.white70,
            padding: EdgeInsets.only(top: margin, left: margin, bottom: margin),
            alignment: Alignment.center,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  iconPath,
                  width: 25,
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.title.copyWith(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: marginLeft),
                  child: Image.asset(
                    ImagePath.ic_arr_2_details,
                    width: 10,
                    height: 10,
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: isItemEnd ? 0 : dividerMargin),
          child: Container(
            height: 1,
            width: double.maxFinite,
            color: Colors.black12,
          ),
        )
      ],
    );
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
  }

  genderRoleString(String role) {
    switch (role) {
      case Constant.admin:
        return Strings.admin;
        break;
      case Constant.agency:
        return Strings.agency;
        break;
      case Constant.business_staff:
        return Strings.business_staff;
        break;
      case Constant.director:
        return Strings.director;
        break;
      case Constant.officer:
        return Strings.officer;
        break;
      default:
        return "---";
    }
  }
}
