import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile/src/app/pages/customer/view/customer_detail.view.dart';
import 'package:mobile/src/app/pages/customer/view/review_customer_view.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class ItemCusomerOwner extends StatefulWidget {
  final item;
  final param;
  CarProfileData dataIocOffline;
  bool isOnline;
  ItemCusomerOwner({ this.item, this.param, this.dataIocOffline, this.isOnline});

  @override
  _ItemCusomerOwnerState createState() => _ItemCusomerOwnerState();
}

class _ItemCusomerOwnerState extends State<ItemCusomerOwner> {

  bool isOwner = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => checkUserOwner());
  }

  Future<void> checkUserOwner() async {
    final resultIsOwner = await Utils.isUserCanAction(widget.item?.owner.id);
    isOwner = resultIsOwner;
    setState(() {
      isOwner = resultIsOwner;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (widget.isOnline == false) return null;
        if (widget.param == Strings.key_create_profile) {
          if (isOwner) {
            NavigatorUtilities.push(
                context,
                ReviewCustomerPage(
                    dataIocOffline: widget.dataIocOffline,
                    idCustomer: widget.item.id));
          } else {
            Fluttertoast.showToast(
              msg: Strings.owner_can_choose,
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              backgroundColor: Colors.red[400],
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        } else {
          final idOwner = widget.item?.owner?.id;
          NavigatorUtilities.push(
              context, CustomerDetail(idCustomer: widget.item.id, param: widget.param, idOwner: idOwner,));
        }
      },
      title: Container(
        margin: EdgeInsets.zero,
        child: new Container(
//          height: 140.0,
          padding: EdgeInsets.only(top: 15),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.grey,
          ))),
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Text(
                      // * name customer
                      widget.item?.fullName ?? '---',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                    ),
                    ),
                  ),
                  Expanded(
                    flex:1,
                    child: Container(
                      height: 25.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: widget.item.type == Strings.key_personal
                            ? Colors.orange
                            : Colors.green[800],
                      ),
                      padding: const EdgeInsets.all(5.0),
                      child: Center(
                        child: Text(
                          widget.item.type == Strings.key_personal
                              ? Strings.personal
                              : Strings.company,
                          style: TextStyle(
                              color: Colors.white, fontSize: 15.0, height: 1.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        "${Strings.manager}:",
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Expanded(
                      flex:4,
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(widget.item?.owner?.fullName ?? "---", textAlign: TextAlign.right,))
                  ),
                ],
              ),
              SizedBox(height: 5.0,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Text(
                        // * name customer
                        '${Strings.address}:',
                        style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                  Expanded(
                    flex:4,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(widget.item?.address ?? "---", textAlign: TextAlign.right,))
                  ),
                ],
              ),
              SizedBox(height: 15.0,),
            ],
          ),
        ),
      ),
    );
  }
}
