import 'package:flutter/material.dart';
import 'package:mobile/src/domain/entities/profile/ProfileResponse.dart';


class BackCupItemCusomerOwner extends StatefulWidget {
  final item;
  final param;
  CarProfileData dataIocOffline;
  BackCupItemCusomerOwner({Key key, this.item, this.param, this.dataIocOffline})
      : super(key: key);

  @override
  BackCupItemCusomerOwnerState createState() => BackCupItemCusomerOwnerState();
}

class BackCupItemCusomerOwnerState extends State<BackCupItemCusomerOwner> {
  @override
  Widget build(BuildContext context) {
    return Text('sss');
    // print("owner");
    // return ListTile(
    //   onTap: () {
    //     if (widget.param == Strings.key_create_profile) {
    //       NavigatorUtilities.push(
    //           context,
    //           ReviewCustomerPage(
    //               dataIocOffline: widget.dataIocOffline,
    //               idCustomer: widget.item.id));
    //     } else {
    //       NavigatorUtilities.push(
    //           context, CustomerDetail(idCustomer: widget.item.id));
    //     }
    //   },
    //   title: Container(
    //     margin: EdgeInsets.zero,
    //     child: new Container(
    //       height: 140.0,
    //       padding: EdgeInsets.only(top: 15),
    //       decoration: BoxDecoration(
    //           border: Border(
    //               bottom: BorderSide(
    //         color: Colors.grey,
    //       ))),
    //       width: double.infinity,
    //       child: Row(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         children: <Widget>[
    //           Container(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: <Widget>[
    //                 Text(
    //                   //! name customer
    //                   widget.item?.fullName ?? '---',
    //                   style:
    //                       TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
    //                 ),
    //                 SizedBox(
    //                   height: 8,
    //                 ),
    //                 Container(
    //                   height: 25.0,
    //                   width: 80.0,
    //                   decoration: BoxDecoration(
    //                     borderRadius: BorderRadius.circular(5.0),
    //                     color: widget.item.type == Strings.key_personal
    //                         ? Colors.orange
    //                         : Colors.green[800],
    //                   ),
    //                   padding: const EdgeInsets.all(5.0),
    //                   child: Center(
    //                     child: Text(
    //                       widget.item.type == Strings.key_personal
    //                           ? Strings.personal
    //                           : Strings.company,
    //                       style: TextStyle(
    //                           color: Colors.white, fontSize: 15.0, height: 1.0),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 8,
    //                 ),
    //                 Container(
    //                   child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.start,
    //                       mainAxisSize: MainAxisSize.max,
    //                       crossAxisAlignment: CrossAxisAlignment.center,
    //                       children: <Widget>[
    //                         Icon(Icons.perm_identity,
    //                             color: Colors.grey[700], size: 16.0),
    //                         SizedBox(
    //                           width: 10,
    //                         ),
    //                         Text(
    //                           widget.item?.owner?.fullName ?? "---",
    //                           style: new TextStyle(
    //                             fontSize: 14.0,
    //                           ),
    //                         )
    //                       ]),
    //                 ),
    //                 SizedBox(
    //                   height: 8,
    //                 ),
    //                 Container(
    //                   child: Center(
    //                     child: Row(
    //                         mainAxisAlignment: MainAxisAlignment.start,
    //                         mainAxisSize: MainAxisSize.max,
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         children: <Widget>[
    //                           Icon(Icons.home,
    //                               color: Colors.grey[600], size: 16.0),
    //                           SizedBox(
    //                             width: 10,
    //                           ),
    //                           Text(
    //                             widget.item?.address ?? '---',
    //                             overflow: TextOverflow.ellipsis,
    //                             style: new TextStyle(
    //                               fontSize: 16.0,
    //                             ),
    //                           )
    //                         ]),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //               ],
    //             ),
    //           ),
    //           Flexible(
    //             child: Column(
    //               children: <Widget>[
    //                 Align(
    //                     alignment: Alignment.centerRight,
    //                     child: Container(
    //                       child: Text(
    //                         widget.item?.status == Strings.ACTIVE
    //                             ? Strings.active
    //                             : (widget.item?.status == Strings.LOCK
    //                                 ? Strings.lock
    //                                 : '---'),
    //                         style: TextStyle(
    //                             color: widget.item?.status == Strings.ACTIVE
    //                                 ? Colors.blue[600]
    //                                 : Colors.red),
    //                         maxLines: 1,
    //                         overflow: TextOverflow.ellipsis,
    //                       ),
    //                     ))
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
