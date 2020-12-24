import 'package:flutter/material.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';

class GuildLineTakeAPhoto extends StatefulWidget {
  @override
  _GuildLineTakeAPhotoState createState() => _GuildLineTakeAPhotoState();
}

class _GuildLineTakeAPhotoState extends State<GuildLineTakeAPhoto> {
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
              Strings.guild_2,
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
                        TextNomarl(
                            'Các trường hợp phải kiểm tra, chụp ảnh xe trước khi nhận bảo hiểm:'),
                        TextBulleted("Xe mới tham bảo hiểm tại BV lần đầu"),
                        TextBulleted(
                            "Xe đã tham gia bảo hiểm tại BV nhưng không tái tục liên tục"),
                        TextBulleted(
                            "Chụp lại ảnh xe trong trường hợp khách hàng nộp phí chậm trước khi thu phí bảo hiểm"),
                        TextBulleted(
                            "Trước khi cấp Thông báo khôi phục hiệu lực Hợp đồng bảo hiểm"),
                        TextNomarl(
                            '(Không áp dụng đối với xe tái tục liền thời hạn bảo hiểm, Xe mới chưa có biển số mua bảo hiểm tại Showroom, xe doanh nghiệp có từ 05 xe trở lên)'),

                        ///TODO
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Hướng dẫn chụp ảnh:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              height: 1.5),
                        ),
                        TextNomarl("Kiểm tra, chụp ảnh tối thiểu 05 ảnh."),
                        TextRichBold('Phía trước:',
                            "đứng tại vị trí góc xe trước, điều chỉnh khoảng cách sao cho khung hình bắt đầu từ góc đầu bên còn lại, kết thúc ở góc sau bên cùng phía."),
                        TextRichBold('Phía sau:',
                            "đứng tại vị trí góc xe sau, điều chỉnh khoảng cách đến xe sao cho khung hình bắt đầu từ góc trước phía bên này, kết thúc tại góc sau phía bên kia."),
                        TextNomarl("Các hình ảnh chụp ảnh xe phải thể hiện được biển số xe;"),
                        SizedBox(height: 10.0,),
                        Center(
                            child: Image.asset(
                              ImagePath.img_new_guild_line,
                              fit: BoxFit.fill,
                            ),
                        ),
                        SizedBox(height: 35.0,),
                        TextDescriptionBold('Ảnh thứ 5:', ' Ảnh đăng kiểm hoặc Số Khung'),
                        SizedBox(height: 20.0,),
                        Center(
                          child: Image.asset(
                            ImagePath.img_new_chassis,
                            fit: BoxFit.fill,
                          ),
                        ),
                        SizedBox(height: 15.0,),
                        TextNomarl("Chụp tem đăng kiểm hoặc số khung: Chụp tem Đăng kiểm thể hiện biển số, thời hạn đăng kiểm lần tới hoặc Chụp số khung của xe."),
                        SizedBox(height: 15.0,),
                        TextDescriptionBold('Ảnh thứ 6:', ' Ảnh kính chắn gió trước.'),
                        SizedBox(height: 15.0,),
                        TextBulleted("Mỗi xe chụp ít nhất 06 ảnh: 04 ảnh xe , 01 ảnh Đăng kiểm/Số khung & 01 ảnh Kính chắn gió ; Với những xe có giá trị cao như: BMW, Audi, Mercedes... phải chụp thêm các góc độ khác: Nóc, các larăng và có thể kiểm tra nổ máy xe."),
                        TextBulleted("Trường hợp phát hiện có hư hỏng cần lập biên bản xác nhận tình trạng xe trước khi nhận bảo hiểm."),
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
      textAlign: TextAlign.justify,
      style: TextStyle(fontSize: 15.0, height: 1.5),
    );
  }

  Widget TextBulleted(String text) {
    return RichText(
      textAlign: TextAlign.justify,
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
            style: TextStyle(color: Colors.black, fontSize: 15.0, height: 1.5)),
      ]),
    );
  }
}
