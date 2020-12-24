import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/customer/customer_controller.dart';
import 'package:mobile/src/app/pages/customer/view/customer_form_create.view.dart';
import 'package:mobile/src/app/pages/customer/view/item_customer_no_owner.view.dart';
import 'package:mobile/src/app/pages/customer/view/item_customer_owner.view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/Constant.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Loading/LoadingJumpingLine.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/WidgetUtilities.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class ListCustomer extends StatefulWidget {
  final items;
  final params;
  CustomerController controller;
  CarProfileData dataIocOffline;
  bool isOnline;

  ListCustomer({this.items, this.params, this.controller, this.dataIocOffline, this.isOnline });

  @override
  _ListCustomerState createState() => _ListCustomerState();
}

class _ListCustomerState extends State<ListCustomer> {
  Size _size;
  Map<String, dynamic> newObjectSearch = Map<String, dynamic>();
  bool isLoading = false;
  int idOwner;

  @override
  void dispose() {
    super.dispose();
    LocalStorageService.saveLimitItems(0);
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 1));
    await widget.controller.getAllCustomer(newObjectSearch, true);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => funcGetIdOwner());
  }

  Future<void> funcGetIdOwner() async {
    final user = await LocalStorageService.getUserInfor();
    setState(() {
      idOwner = user?.result?.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("param list customer ${widget.params}");
    _size = MediaQuery.of(context).size;
    return Scaffold(
      key: RIKeys.riKey,
      body: Column(
        children: <Widget>[
          (widget.isOnline == false)
           ?  WidgetUitlites.offlineView(context): SizedBox(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Strings.list_customer,
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
          ),
          WidgetUitlites.processBarWidget(context),
          Expanded(
            child: Container(
              child: widget.items.length <= 0
                  ? _widgetShowButtonAddCusomer(context)
                  : NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          _loadData();
                          // start loading data
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: _Items(context),
                    ),
              width: double.infinity,
            ),
          ),
          isLoading ? LoadingStypeLine() : SizedBox(),
        ],
      ),
    );
  }

  Widget _Items(BuildContext context) {
    return ListView.builder(
      itemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            child:
//            idOwner == widget.items[index].owner.id
        widget.items[index].canRead
                ? ItemCusomerOwner(
                    item: widget.items[index], param: widget.params, dataIocOffline : widget.dataIocOffline, isOnline : widget.isOnline)
                : ItemCusomerNoOwner(item: widget.items[index]));
      },
    );
  }

  Widget _widgetShowButtonAddCusomer(BuildContext context) {
    if (widget.params == Strings.key_create_profile) {
      return new Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    ImagePath.search,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(Strings.empty_data),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 180.0,
                    height: 50.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.amber[600],
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: FlatButton(
                      textColor: Colors.white,
                      child: Text(
                        Strings.create_new,
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      onPressed: () {
                        final param = Constant.key_create_when_searching;
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    new CustomerCreateForm(param)));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    ImagePath.search,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(Strings.empty_data),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}
class RIKeys {
  static final riKey = const Key('__LIST_ITEM_CUSTOMER__');
}