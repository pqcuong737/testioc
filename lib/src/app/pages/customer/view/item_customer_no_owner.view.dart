import 'package:flutter/material.dart';
import 'package:mobile/src/utility/Strings.dart';

class ItemCusomerNoOwner extends StatefulWidget {
  final item;
  ItemCusomerNoOwner({this.item});
  final flag = true;
  @override
  _ItemCusomerOwnerState createState() => _ItemCusomerOwnerState();
}

class _ItemCusomerOwnerState extends State<ItemCusomerNoOwner> {
  @override
  Widget build(BuildContext context) {
    print("no owner");
    return ListTile(
      onTap: () {},
      title: Container(
        child: Opacity(
          opacity: 0.50,
          child: new Container(
            padding: EdgeInsets.only(top: 15),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Colors.grey.withOpacity(0.50),
            ))),
            // width: double.infinity,
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
                            child: Text(widget.item?.owner?.fullName ?? "---"))
                    ),
                  ],
                ),
                SizedBox(height: 5.0,),
                Row(
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
                            child: Text(widget.item.address))
                    ),
                  ],
                ),
                SizedBox(height: 15.0,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
