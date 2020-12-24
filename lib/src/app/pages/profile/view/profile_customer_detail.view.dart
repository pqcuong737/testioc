import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/src/utility/Strings.dart';

class ProfileCustomerDetailPage extends StatefulWidget {
  final data;

  ProfileCustomerDetailPage(this.data);

  @override
  _ProfileCustomerDetailPageState createState() =>
      _ProfileCustomerDetailPageState();
}

class _ProfileCustomerDetailPageState extends State<ProfileCustomerDetailPage> {
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
                      Strings.infor_profile,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15.7),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
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
                            Strings.id_profile,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "${widget.data?.id}" ?? '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO STATUS
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
                            Strings.status,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.status == 'COMPLETED'
                                ? Strings.completed
                                : (widget.data?.status == 'DRAFT'
                                    ? Strings.draft
                                    : (widget.data?.status == 'REJECTED'
                                        ? Strings.rejected
                                        : (widget.data?.status == 'APPROVED'
                                            ? Strings.approved
                                            : Strings.deactive))),
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: widget.data?.status == 'COMPLETED'
                                  ? Colors.green[800]
                                  : (widget.data?.status == 'DRAFT'
                                      ? Colors.orange
                                      : (widget.data?.status == 'REJECTED'
                                          ? Colors.red
                                          : (widget.data?.status == 'APPROVED'
                                              ? Colors.blueAccent
                                              : Colors.red[200]))),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO GCNBH
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
                                Strings.GCNBH,
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
                            widget.data?.printeMattersNumber != null
                                ? "${widget.data?.printeMattersNumber}"
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
              //TODO Create
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
                            Strings.create_at,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.createdAt != null
                                ? 
                                '${DateTime.parse('${widget.data?.createdAt}').day}/${DateTime.parse('${widget.data?.createdAt}').month}/${DateTime.parse('${widget.data?.createdAt}').year} ${DateFormat.jm().format(DateTime.parse('${widget.data?.createdAt}')) }'
                                //  '${DateFormat.yMd().add_jm().format(DateTime.parse('${widget.data?.createdAt}'))}'
                                : "---",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              ///TODO  AppliedDay
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
                            Strings.applied_day,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.effectiveDate != null
                                ?
                                widget.data?.effectiveDate
                                // '${DateFormat.yMd().add_jm().format(DateTime.parse('${widget.data?.effectiveDate}'))}'
//                                '${DateTime.parse('${widget.data?.effectiveDate}').day}/${DateTime.parse('${widget.data?.effectiveDate}').month}/${DateTime.parse('${widget.data?.effectiveDate}').year} ${DateFormat.jm().format(DateTime.parse('${widget.data?.effectiveDate}')) }'
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

              ///TODO  UpdateAt
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
                            Strings.updated_at,
                            style: TextStyle(fontSize: 16.0),
                          )),
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.updatedAt != null
                                ? 
                                // '${DateFormat.yMd().add_jm().format(DateTime.parse('${widget.data?.updatedAt}'))}'
                                '${DateTime.parse('${widget.data?.updatedAt}').day}/${DateTime.parse('${widget.data?.updatedAt}').month}/${DateTime.parse('${widget.data?.updatedAt}').year} ${DateFormat.jm().format(DateTime.parse('${widget.data?.updatedAt}')) }'
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
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 25, 0, 25),
                child: Row(
                  children: <Widget>[
                    Text(
                      Strings.infor_customer,
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 15.7),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              //TODO name
              Container(
                color: Colors.white,
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
                          child: Row(
                            children: <Widget>[
                              Text(
                                Strings.name,
                                style: TextStyle(fontSize: 16.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                "*",
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
                            widget.data.customer?.fullName != null
                                ? widget.data.customer?.fullName
                                : '---',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontSize: 16.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //TODO Identity
              widget.data?.customer?.type == Strings.key_personal
                  ? Container(
                      color: Colors.white,
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
                                  Strings.identity,
                                  style: TextStyle(fontSize: 16.0),
                                )),
                            Container(
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 210),
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  widget.data?.customer?.identity != null
                                      ? widget.data?.customer?.identity
                                      : '---',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Container(
                      color: Colors.white,
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
                                  Strings.tax_code,
                                  style: TextStyle(fontSize: 16.0),
                                )),
                            Container(
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 210),
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  widget.data?.customer?.identity != null
                                      ? widget.data?.customer?.identity
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
              widget.data?.customer?.type == Strings.key_personal
                  ? Container(
                      color: Colors.white,
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
                                  Strings.brithday,
                                  style: TextStyle(fontSize: 16.0),
                                )),
                            Container(
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 210),
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  widget.data?.customer?.birthday != null
                                      ?
                                     '${DateTime.parse('${widget.data?.customer?.birthday}').day}/${DateTime.parse('${widget.data?.customer?.birthday}').month}/${DateTime.parse('${widget.data?.customer?.birthday}').year}'
//                                  '${DateFormat.yMd().format(DateTime.parse('${widget.data?.customer?.birthday}'))}'
                                      : '---',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),

              //TODO Gender
              widget.data?.customer?.type == Strings.key_personal
                  ? Container(
                      color: Colors.white,
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
                                  Strings.gender,
                                  style: TextStyle(fontSize: 16.0),
                                )),
                            Container(
                              constraints:
                                  BoxConstraints(minWidth: 100, maxWidth: 210),
                              padding: const EdgeInsets.only(bottom: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Text(
                                  widget.data?.customer?.gender != null
                                      ? (widget.data?.customer?.gender ==
                                              Strings.key_male
                                          ? Strings.male
                                          : (widget.data?.customer?.gender ==
                                                  Strings.key_female
                                              ? Strings.female
                                              : Strings.other))
                                      : '---',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
              //TODO Address
              Container(
                color: Colors.white,
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
                          child: Row(
                            children: <Widget>[
                              Text(
                                Strings.address,
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
                      Container(
                        constraints:
                            BoxConstraints(minWidth: 100, maxWidth: 210),
                        padding: const EdgeInsets.only(bottom: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            widget.data?.customer?.address != null
                                ? widget.data?.customer?.address
                                : "---",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 16.0),
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
    );
  }
}
