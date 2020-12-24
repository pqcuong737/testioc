import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_form_create.view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/app/pages/guild_line/guild_line_menu.view.dart';
import 'package:mobile/src/app/pages/profile/view/profile_list_view.dart';
import 'package:mobile/src/app/pages/technical_support/technical_support.view.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/domain/entities/menu_home.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/domain/repositories/profile/profile_repository.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';

import 'home_controller.dart';

class HomePage extends View {
  UserInfor _userInfor;

  HomePage(UserInfor userInfor) {
    this._userInfor = userInfor;
  }

  @override
  _HomePageState createState() => // inject dependencies inwards
      _HomePageState(_userInfor);
}

class _HomePageState extends ViewState<HomePage, HomeController> {
  UserInfor _userInfor;

  _HomePageState(this._userInfor) : super(HomeController(ProfileRepository()));

  Size _size;
  double _headerHeight = 0;
  StreamSubscription<ConnectivityResult> subscription;
  bool isOnlineView = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.requestLocationPermission(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    subscription.cancel();
  }

  @override
  Widget buildPage() {
    _size = MediaQuery.of(context).size;
    _headerHeight = _size.height * .23;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      key: globalKey,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              _buildHeaderWidget(context, isOnlineView),
              _buildBodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderWidget(BuildContext context, bool isOnline) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: _headerHeight - 30,
            color: Color.fromRGBO(49, 123, 210, 1),
          ),
          Container(
            height: _headerHeight + 20,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: _headerHeight * .1,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'BAOVIET',
                          style: Theme.of(context).textTheme.headline.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'HCM IOC',
                          style: Theme.of(context)
                              .textTheme
                              .headline
                              .copyWith(color: Colors.white),
                        )
                      ],
                    )),
                    Image.asset(
                      'assets/icons/ic_bell.png',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                Expanded(
                  child: Container(),
                ),
                _buildUserInfoWidget(context, isOnline),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildUserInfoWidget(BuildContext context, bool isOnline) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 0,
            color: Colors.black12.withOpacity(.1),
            offset: const Offset(0, 2),
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: _userInfor?.result?.avatarUrl != null
                ? Image.network(
                    _userInfor.result.avatarUrl,
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
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _userInfor != null ? _userInfor.result.fullName : "",
                maxLines: 1,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                controller.genderRoleString(widget?._userInfor?.result?.role),
                style: Theme.of(context).textTheme.body1,
              )
            ],
          )),
          isOnline == false
              ? Icon(
                  Icons.perm_scan_wifi,
                  color: Colors.red,
                )
              : SizedBox(),
        ],
      ),
    );
  }

  Widget _buildBodyWidget(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          WidgetUitlites.processBarWidget(context),
          const SizedBox(height: 8),
          _buildSectionWidget(context),
          const SizedBox(height: 8),
          _buildSubMenuWidget(context),
          const SizedBox(height: 10),
          _buildGridMenuWidget(context),
        ],
      ),
    );
  }

  Widget _buildSectionWidget(BuildContext context) {
    return Container(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: _size.width * .75,
              height: .5,
              color: Colors.black12.withOpacity(.2),
            ),
            Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                Strings.popular_activity,
                style: Theme.of(context)
                    .textTheme
                    .subhead
                    .copyWith(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubMenuWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: _buildSubMenuItem(
              context,
              Colors.blue,
              ImagePath.ic_profile,
              Strings.create_profile,
              //  controller.homePresenter.tagOnCreateProfile
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: _buildSubMenuItem(
              context,
              Colors.orange,
              ImagePath.ic_plus_customer,
              Strings.customer,
              //  controller.homePresenter.tagOnCustomer
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubMenuItem(BuildContext context, Color backgroundColor,
      String iconPath, String text) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: backgroundColor.withOpacity(.75),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              spreadRadius: 0,
              color: Colors.black12.withOpacity(.05),
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: InkWell(
          onTap: () async {
            final param = Strings.key_ceate_customer;
            if (text == Strings.customer) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerCreateForm(param),
                ),
              );
            } else if (await Utils.isInternetConnected()) {
              final param = Strings.key_create_profile;
              NavigatorUtilities.push(context, CustomerListPage(param: param));
            } else {
              final dataCar = new CarProfileData();
              final mapNewProfileData = controller.createNewProfileData();
              NavigatorUtilities.push(
                  context,
                  CarInfoPage(
                    data: dataCar,
                    profileId: mapNewProfileData.key,
                    // customerId: widget.customerId
                  ));
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Stack(
              children: <Widget>[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(5),
                          child: Image.asset(
                            iconPath,
                            width: 20,
                            height: 20,
                          ),
//                        child: Icon(Icons.person_add),
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          text,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .body1
                              .copyWith(color: Colors.white),
                        ),
                      ))
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Opacity(
                    opacity: 0.5,
                    child: Image.asset(
                      ImagePath.ic_logo,
                      width: 64,
                      height: 45,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildGridMenuWidget(BuildContext context) {
    final itemWidth = _size.width / 2;
    final itemHeight = itemWidth * 2 / 3;
    return Container(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.dataSet.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
          childAspectRatio: (itemWidth / itemHeight),
        ),
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child:
                  _buildGridItemWidget(context, controller.dataSet[index], () {
            if (index == 0) {
              final param = 'grid_to_list_profile';
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ListProfilePage(param),
                ),
              );
            } else if (index == 1) {
              final menuToListCustomer = Strings.key_ceate_customer;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CustomerListPage(param: menuToListCustomer),
                ),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GuildLineMenu(),
                ),
              );
//              controller.tagOnMenu(index);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TechnicalPage(),
                ),
              );
            }
          }));
        },
      ),
    );
  }

  Widget _buildGridItemWidget(
      BuildContext context, MenuEntity item, Function callBack) {
    return Material(
      color: Colors.white,
      elevation: 0,
      child: InkWell(
        onTap: callBack,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset(
                item.icon,
                width: 50,
                height: 50,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                item?.title ?? '',
                style: Theme.of(context)
                    .textTheme
                    .body2
                    .copyWith(color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onConnectivityListener(bool result) {
    if (controller.isOnline == false && result) {
      controller.isOnline = true;
      controller.handleConnectionStatusChanged();
    } else {
      controller.isOnline = false;
    }
    setState(() {
      isOnlineView = result;
    });
  }
}
