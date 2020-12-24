import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/app/pages/car_info/step_1/car_info_view.dart';
import 'package:mobile/src/app/pages/customer/view/customer_view.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class ListProfileOffline extends StatefulWidget {
  var data;
  int index;

  ListProfileOffline(this.data, this.index);

  @override
  _ListProfileOfflineState createState() => _ListProfileOfflineState();
}

class _ListProfileOfflineState extends State<ListProfileOffline> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        if (await Utils.isInternetConnected()) {
          // final param = Strings.key_create_profile;
          // NavigatorUtilities.push(context, CustomerListPage(param: param, dataIocOffline: widget.data));
        } else {
          NavigatorUtilities.push(
              context,
              CarInfoPage(
                data: widget.data,
                profileId: widget.data.idOffline,
                // customerId: widget.customerId
              ));
        }
      },
      title: Container(
        margin: EdgeInsets.zero,
        child: new Container(
          height: 100.0,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: widget.data?.imgCarFrontPositionRight != null
                                ?
//                                Image.file(
//                                    File(widget.data?.imgCarFrontPositionRight),
//                                    width: 60,
//                                    height: 60,
//                                    fit: BoxFit.cover)
                                Image.asset(
//                                    "${widget.data?.imgCarFrontPositionRight}",
                                     "https://img.gaadicdn.com/images/carexteriorimages/930x620/Skoda/Skoda-Octavia/5916/front-left-side-47.jpg",
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.cover)
                                : Image.asset(
                                    ImagePath.thumb,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        flex: 4,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0, color: Colors.grey))),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Ioc_Offine_${widget.index + 1}',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Text(
                                          widget.data?.contractNumber != null
                                              ? 'Mã HĐ: ${widget.data?.contractNumber}'
                                              : '---',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.grey[700]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      child: Container(
                                        color: Colors.white,
                                        padding: const EdgeInsets.all(5),
                                        child: Image.asset(
                                          ImagePath.ic_load,
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 12.0,
                                ),
                                Stack(
                                  alignment: Alignment.centerLeft,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Text(
                                          "Offline",
                                          style: TextStyle(
                                              color: Colors.redAccent),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
//                                         SizedBox(
//                                           height: 8.0,
//                                         ),
//                                         Text(
// //                                                    '${DateFormat.yMd().format(DateTime.parse('${widget.listProfile[index]?.createdAt}'))}',
//                                           widget,
//                                           style: TextStyle(
//                                               color: Colors.blue[600]),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
//                                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
