import 'package:flutter/material.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';

class GuildLineCustomer extends StatefulWidget {
  @override
  _GuildLineCustomerState createState() => _GuildLineCustomerState();
}

class _GuildLineCustomerState extends State<GuildLineCustomer> {
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
              Strings.guild_detail_3,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: SafeArea(
                top: true,
                left: true,
                right: true,
                bottom: true,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextRichBold("Bước 1: ",
                            "NVKD/Đại lý có thể tạo nhanh khách hàng ở Home hoặc nhấn chọn dấu + trong danh sách khách hàng "),
                        Center(
                          child: Image.asset(
                            ImagePath.img_step_create_customer,
                            fit: BoxFit.fill,
                          ),
                        ),
                        TextRichBold("Bước 2: ",
                            "Chọn loại Khách hàng: Tổ chức, Cá nhân"),
                        TextRichBold("Bước 3: ",
                            "Điền các thông tin cần thiết của Khách hàng"),
                        TextRichBold(
                            "Bước 4: ", "Nhấn hoàn tất để lưu Khách hàng"),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextNomarl(
                            "NVKD/Đại lý có thể tra cứu thông tin Khách hàng bằng cách nhập Tên hoặc MST/CMND để tìm kiếm và xem thông tin."),
                        SizedBox(
                          height: 8.0,
                        ),
                        Center(
                          child: Image.asset(
                            ImagePath.img_step_search_customer,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget TextNomarl(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 15.0, height: 1.5),
      textAlign: TextAlign.justify,
    );
  }

  Widget TextBulleted(String text) {
    return RichText(
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "${String.fromCharCode(0x2022)} ",
            style: TextStyle(color: Colors.grey, fontSize: 20.0, height: 1.5)),
        TextSpan(
            text: text,
            style: TextStyle(color: Colors.black, fontSize: 15.0, height: 1.5)),
      ]),
    );
  }

  Widget TextRichBold(String bold, String normal) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: "${String.fromCharCode(0x2022)} ",
            style: TextStyle(color: Colors.grey, fontSize: 20.0, height: 1.5)),
        TextSpan(
            text: bold,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                height: 1.5)),
        TextSpan(
            text: normal,
            style: TextStyle(color: Colors.black, fontSize: 15.0, height: 1.5)),
      ]),
    );
  }

  Widget TextDescriptionBold(String bold, String normal) {
    return RichText(
      textAlign: TextAlign.justify,
      text: TextSpan(children: <TextSpan>[
        TextSpan(
            text: bold,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                height: 1.5)),
        TextSpan(
          text: normal,
          style: TextStyle(color: Colors.black, fontSize: 15.0, height: 1.5),
//            textAlign: TextAlign.justify,
        ),
      ]),
    );
  }
}
