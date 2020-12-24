import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/app/pages/profile/view/show_image.view.dart';
import 'package:mobile/src/app/pages/profile/view/show_video.view.dart';
import 'package:mobile/src/app/pages/profile/view/test_view_video.view.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:video_player/video_player.dart';

class ProfileDetailCarPage extends StatefulWidget {
  final data;

  ProfileDetailCarPage(this.data);

  @override
  _ProfileDetailCarPageState createState() => _ProfileDetailCarPageState();
}

class _ProfileDetailCarPageState extends State<ProfileDetailCarPage> {
  Size _size;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      left: true,
      bottom: true,
      right: true,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                child: Row(
                  children: <Widget>[
                    Text(
                      Strings.infor_basic,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15.7),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              //TODO Type Car
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.type_car,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.carCategory?.parent?.name != null
                                ? "${widget.data?.carCategory?.parent?.name}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO Car
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.car,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.carCategory?.name != null
                                ? "${widget.data?.carCategory?.name}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO Xilanh
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.cylinder,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.cylinder != null
                                ? "${widget.data?.cylinder}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO Price
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.price_car,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget?.data?.priceCar != null
                                ? "${NumberFormat.currency(locale: 'vi', symbol: 'Triệu đồng', decimalDigits: 0).format(widget.data?.priceCar)}"
                                : '0',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 16.0, color: Colors.orange[600]),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO License Plates
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            children: <Widget>[
                              Text(
                                Strings.license_plates,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                '*',
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.licensePlates != null
                                ? "${widget.data?.licensePlates}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO chassis number
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.chassis_number,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.chassisNumber != null
                                ? "${widget.data?.chassisNumber}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO vehicle number
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.vehicle_number,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.vehicleNumber != null
                                ? "${widget.data?.vehicleNumber}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///TODO  manufacturing year
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.manufacturing_year,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.manufacturingYear != null
                                ? '${widget.data?.manufacturingYear}'
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///TODO  use year
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            Strings.used_year,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.usedYear != null
                                ? "${widget.data?.usedYear}"
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///----------------------------
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                child: Row(
                  children: <Widget>[
                    Text(
                      Strings.status_car,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15.7),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              ///TODO  vehicle Status
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                Strings.vehicle_status,
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: 100, maxWidth: 210),
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                                onTap: () {},
                                child:
                                    widget.data?.vehicleStatusIsNormal != true
                                        ? Text(
                                            Strings.vehicle_status_ok,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 16.0),
                                          )
                                        : Text(
                                            Strings.vehicle_status_wrong,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(fontSize: 16.0),
                                          )),
                          )
                        ],
                      ),
                      widget.data?.vehicleStatusIsNormal != true
                          ? SizedBox()
                          : Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                widget.data?.vehicleStatus != null
                                    ? '${widget.data?.vehicleStatus}'
                                    : '---',
                                style: TextStyle(fontSize: 16.0),
                              ))
                    ],
                  ),
                ),
              ),

              ///TODO  scratches
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                Strings.scratches,
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: 100, maxWidth: 210),
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                widget.data?.isScratched
                                    ? Strings.yes
                                    : Strings.no,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: widget.data?.isScratched
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget.data?.isScratched
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                widget.data?.scratches != null
                                    ? '${widget.data?.scratches}'
                                    : '---',
                                style: TextStyle(fontSize: 16.0),
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
              ),

              ///TODO  vehicle Status
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                Strings.upgrade_car,
                                style: TextStyle(fontSize: 16.0),
                              )),
                          Container(
                            constraints:
                                BoxConstraints(minWidth: 100, maxWidth: 210),
                            padding: const EdgeInsets.only(bottom: 20),
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                widget.data?.extraAccessories
                                    ? Strings.yes
                                    : Strings.no,
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                    color: widget.data?.extraAccessories
                                        ? Colors.blue
                                        : Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                      widget?.data?.extraAccessories
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                widget.data?.upgradeCar != null
                                    ? '${widget.data?.upgradeCar}'
                                    : '---',
                                style: TextStyle(fontSize: 16.0),
                              ))
                          : SizedBox(),
                    ],
                  ),
                ),
              ),

              ///TODO note
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Text(
                                Strings.note,
                                style: TextStyle(fontSize: 16.0),
                              )),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            widget.data?.note ?? '---',
                            style: TextStyle(fontSize: 16.0),
                          )),
                    ],
                  ),
                ),
              ),

              ///----Images
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                child: Row(
                  children: <Widget>[
                    Text(
                      Strings.images,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15.7),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              ///img_car_front_position_left
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.img_car_front_position_left,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgCarFrontPositionLeft),
                  ]),
                ),
              ),

              ///TODO img_car_front_position_right
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.img_car_front_position_right,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgCarFrontPositionRight),
                  ]),
                ),
              ),

              ///TODO img_car_rear_position_right
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.img_car_rear_position_right,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgCarRearPositionRight),
                  ]),
                ),
              ),

              ///TODO img_car_rear_position_left
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.img_car_rear_position_left,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  "*",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgCarRearPositionLeft),
                  ]),
                ),
              ),

              ///TODO img_chassis
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.img_chassis,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgChassis),
                  ]),
                ),
              ),

              ///TODO img_windshield
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  Strings.car_windshield,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '*',
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )),
                      ],
                    ),
                    ImgView(widget.data?.imgWindshield),
                  ]),
                ),
              ),

              ///TODO extend images
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              Strings.image_extends,
                              style: TextStyle(fontSize: 16.0),
                            )),
                      ],
                    ),
                  ]),
                ),
              ),
              Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: widget.data?.imageExtends.length > 0
                        ? Wrap(
                            children:
                                widget.data?.imageExtends.map<Widget>((value) {
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ImgView(value.url),
                                ),
                              );
                            }).toList(),
                          )
                        : Center(
                            child: Container(
                              width: 115,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  ImagePath.thumb,
                                  width: 115,
                                  height: 115,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                  )),

              ///TODO video
              Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.4),
                  )),
                  child: Column(children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              Strings.video,
                              style: TextStyle(fontSize: 16.0),
                            )),
                      ],
                    ),
                    Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: widget.data?.video != null
                            ? ChewieListItem(
                                videoPlayerController:
                                    VideoPlayerController.network(
//                                        "http://clips.vorwaerts-gmbh.de/VfE_html5.mp4"
//                                        "https://ipfs-bvhcm.vndigitech.com/ipfs/QmQyGHJNTp8sNhCdmx1qZy8Cd6kYXnMMU4URH5ToUdLp8T"
                                        widget.data?.video
                                        ),
                                looping: true,
                              )
//                        SizedBox(
//                          width: 300.0,
//                          height: 300.0,
//                          child: VideoApp(widget.data?.video)
//                        )
                            : Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Image.asset(
                                    ImagePath.thumb,
                                    width: 115,
                                    height: 115,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ))
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
