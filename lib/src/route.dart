// import 'package:fluro/fluro.dart';
// import 'package:flutter/material.dart';
// import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
// import 'package:mobile/src/app/pages/car_info/step_2/car_status_view.dart';
// import 'package:mobile/src/app/pages/car_info/step_3/car_image_view.dart';
// import 'package:mobile/src/app/pages/customer/view/customer_form_create.view.dart';
// import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
// import 'package:mobile/src/app/pages/home/main_home_view.dart';
// import 'package:mobile/src/app/pages/profile/view/profile_list_view.dart';
// import 'package:mobile/src/app/pages/user_profile/agency_infor_view.dart';
// import 'package:mobile/src/app/pages/user_profile/change_pass_view.dart';
// import 'package:mobile/src/app/pages/user_profile/invidual_infor_view.dart';
// import 'package:mobile/src/app/pages/user_profile/profile_lading.dart';

// class FluroRouter {
//   static Router router = Router();

//   static Handler _home = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           MainHomePage(params['param'][0]));

//   // static Handler _listCustomer = Handler(
//   //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//   //         CustomerListPage(params['param'][0]));

//   static Handler _listProfile = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           ListProfilePage(params['param'][0]));

//   static Handler _createCustomerFom = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           CustomerCreateForm(params['param'][0]));

//   static Handler _userProfile = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           ProfileLanding());

//   static Handler _changePassword = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           ChangePassView());

//   static Handler _agency_infor = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           AgencyInforView());

//   static Handler _invidual_infor = Handler(
//       handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
//           InviDualInforView());

// //  static Handler _privew_infor_customer = Handler(
// //      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
// //          ReviewCustomerPage(
// //              params['id'][0],
// //              params['fullName'][0],
// //              params['identity'][0],
// //              params['birthday'][0],
// //              params['gender'][0],
// //              params['address'][0],
// //              params['type'][0]));

//   static void setupRouter() {
//     // router.define('${NavigationName.LIST_CUSTOMERS}:param',
//     //     handler: _listCustomer, transitionType: TransitionType.inFromRight);

//     router.define('${NavigationName.LIST_PROFILE}:param',
//         handler: _listProfile, transitionType: TransitionType.inFromBottom);
//     router.define('${NavigationName.CREATE_CUSTOMER}:param',
//         handler: _createCustomerFom,
//         transitionType: TransitionType.materialFullScreenDialog);

//     router.define('${NavigationName.PROFILE_LANDING}:param',
//         handler: _userProfile,
//         transitionType: TransitionType.materialFullScreenDialog);

//     router.define('${NavigationName.CHANGE_PASS}:param',
//         handler: _changePassword,
//         transitionType: TransitionType.materialFullScreenDialog);

//     router.define('${NavigationName.INVIDUAL_INFOR}:param',
//         handler: _invidual_infor,
//         transitionType: TransitionType.materialFullScreenDialog);

//     router.define('${NavigationName.AGENCY_INFOR}:param',
//         handler: _agency_infor,
//         transitionType: TransitionType.materialFullScreenDialog);

//     router.define('${NavigationName.HOME}:param',
//         handler: _home,
//         transitionType: TransitionType.materialFullScreenDialog);
//   }
// }

// class NavigationName {
//   static const String HOME = '/home/';
//   static const String LOGIN = '/login/';
//   static const String PROFILE_LANDING = '/profile_landing/';
//   static const String CHANGE_PASS = '/change_pass/';
//   static const String INVIDUAL_INFOR = '/invidual_infor/';
//   static const String AGENCY_INFOR = '/agency_infor/';
//   static const String LIST_CUSTOMERS = '/list-customer/';
//   static const String LIST_PROFILE = '/list-profile/';
//   static const String CREATE_CUSTOMER = '/create-customer/';
// }
