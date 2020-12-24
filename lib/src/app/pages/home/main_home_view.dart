import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/home/home_view.dart';
import 'package:mobile/src/app/pages/user_profile/profile_lading.dart';
import 'package:mobile/src/domain/entities/login/UserInfor.dart';
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/Strings.dart';

class MainHomePage extends StatefulWidget {
  @override
  MainHomeState createState() => MainHomeState(userInfor);

  final UserInfor userInfor;
  MainHomePage(this.userInfor);

}

class MainHomeState extends State<MainHomePage> {
  int _selectedIndex = 0;

  UserInfor _userInfor;
  List<Widget> views;
  MainHomeState(UserInfor _userInfor){
    this._userInfor = _userInfor;

    views = [
      HomePage(this._userInfor),
      ProfileLanding()
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    APIProvider().mContext = context;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        brightness: Brightness.light, primaryColor: Colors.blue[600]),
    home:Scaffold(
      backgroundColor: Colors.grey[100],
      body: views[_selectedIndex],
      bottomNavigationBar:
      BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(Strings.home)
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(Strings.setting)
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    ));
  }

  void _onItemTapped(int index) {
    if(index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else{
//      final param = 'go_to_profile_landing';
//      Navigator.pushNamed(
//          context, '${NavigationName.PROFILE_LANDING}${param}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileLanding(),
        ),
      );

    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    APIProvider().mContext = null;
  }
}

