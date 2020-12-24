import 'package:flutter/material.dart';
import 'package:mobile/src/app/pages/guild_line/guild_line_create_ioc.view.dart';
import 'package:mobile/src/app/pages/guild_line/guild_line_customer.view.dart';
import 'package:mobile/src/app/pages/guild_line/guild_line_take_a_photo.view.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';

class GuildLineMenu extends StatefulWidget {
  @override
  _GuildLineMenuState createState() => _GuildLineMenuState();
}

class _GuildLineMenuState extends State<GuildLineMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.grey[150],
        ),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[600],
            leading: IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.keyboard_backspace),
                color: Colors.white,
                onPressed: () => Navigator.pop(context)),
            title: Text(
              Strings.title_guild_line,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0),
            ),
          ),
          body: Center(
            child: SafeArea(
              top: true,
              bottom: true,
              left: true,
              right: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 40.0,
                    ),
                    Center(
                      child: Image.asset(
                        ImagePath.img_guild,
                        width: 70,
                        height: 80,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 50.0,
                    ),

                    ///TODO Guild 1
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuildLineCreateIoc(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2),
                        )),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text(
                                Strings.guild_1,
                                style: TextStyle(
                                    color: Colors.blue[400], fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue[400],
                                    )))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///TODO Guild 2
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuildLineTakeAPhoto(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2),
                        )),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text(
                                Strings.guild_2,
                                style: TextStyle(
                                    color: Colors.blue[400], fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue[400],
                                    )))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),

                    ///TODO Guild 1
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GuildLineCustomer(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                            border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.2),
                        )),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Text(
                                Strings.guild_3,
                                style: TextStyle(
                                    color: Colors.blue[400], fontSize: 15.0),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.blue[400],
                                    )))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
