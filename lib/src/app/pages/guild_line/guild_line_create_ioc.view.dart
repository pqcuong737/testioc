import 'package:flutter/material.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/Strings.dart';

class GuildLineCreateIoc extends StatefulWidget {
  @override
  _GuildLineCreateIocState createState() => _GuildLineCreateIocState();
}

class _GuildLineCreateIocState extends State<GuildLineCreateIoc> {
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
              Strings.guild_1,
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
                            'NVKD/Đại lý sẽ được sử dụng Mobile App để tạo Hồ sơ IOC. Hồ sơ được tạo sẽ được lưu trữ trên hệ thống và có thể xem bằng Mobile App và Web App. Nhân viên kiểm duyệt và cấp quản lý sẽ sử dụng Web App để xem và duyệt hồ sơ.'),
                        SizedBox(height: 8.0,),
                        TextNomarl("Nhân viên tư vấn viên, khai thác viên đăng nhập vào Mobile App và thực hiện các thao tác sau:"),
                        TextRichBold(
                            "Bước 1: ", "Chọn tạo hồ sơ nhanh ở Home hoặc nhấn chọn dấu + trong danh sách hồ sơ "),
                        Center(
                          child: Image.asset(
                            ImagePath.img_gl_step1,
                            fit: BoxFit.fill,
                          ),
                        ),
                        TextRichBold(
                            "Bước 2: ","Tìm kiếm Khách hàng (Tên hoặc MST/CMND) và chọn Khách hàng (Nếu Khách hàng chưa tồn tại thì cho phép tạo Khách hàng mới)"),
                        SizedBox(height: 5.0,),
                        Center(
                          child: Image.asset(
                            ImagePath.img_gl_step2,
                            fit: BoxFit.fill,
                          ),
                        ),
                        TextRichBold(
                            "Bước 3: ", "Điền các thông tin cần thiết của Hồ sơ, chụp hình xe"),

                        ///TODO
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Hướng dẫn lưu hồ sơ:',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              height: 1.5),
                        ),
                    Center(
                          child: Image.asset(
                            ImagePath.img_save_ioc,
                            fit: BoxFit.fill,
                          ),
                        ),
                        TextDescriptionBold("Lưu tạm: " ,"Trạng thái hồ sơ chưa hoàn thành, NVKD/Đại lý vẫn đang tiếp tục cập nhật thông tin hồ sơ"),
                        TextDescriptionBold('Hoàn tất: ',
                            "Trạng thái hồ sơ đã điền đẩy đủ thông tin để các bộ phận Duyệt có thể duyệt. Khi user nhấn Hoàn tất, các trường thông tin bắt buộc (Biển số xe, Số khung, Số hợp đồng, Số GCNBH/Ấn chỉ, 6 hình bắt buộc) sẽ được kiểm tra, nếu chưa có sẽ yêu cầu người dùng cung cấp đủ thông tin."),
//                        TextRichBold('Phía sau:',
//                            "đứng tại vị trí góc xe sau, điều chỉnh khoảng cách đến xe sao cho khung hình bắt đầu từ góc trước phía bên này, kết thúc tại góc sau phía bên kia."),
                        SizedBox(height: 5.0,),
                        TextNomarl("Trường hợp Offline khi NVKD/Đại lý thực hiện tạo hồ sơ trong điều kiện Máy điện thoại không có kết nối internet (Wifi hoặc 3G/4G): NVKD/Đại lý vẫn có thể tạo Hồ sơ và chụp hình, khi có kết nối mạng lại thì khi vào Home, App sẽ tự động đồng bộ hồ sơ lên server"),
                        SizedBox(height: 10.0,),

//                        SizedBox(height: 35.0,),
//                        TextDescriptionBold('Ảnh thứ 5:', ' Ảnh đăng kiểm hoặc Số Khung'),
//                        SizedBox(height: 20.0,),
//                        Center(
//                          child: Image.asset(
//                            ImagePath.img_new_chassis,
//                            fit: BoxFit.fill,
//                          ),
//                        ),
//                        SizedBox(height: 15.0,),
//                        TextNomarl("Chụp tem đăng kiểm hoặc số khung: Chụp tem Đăng kiểm thể hiện biển số, thời hạn đăng kiểm lần tới hoặc Chụp số khung của xe."),
//                        SizedBox(height: 15.0,),
//                        TextDescriptionBold('Ảnh thứ 6:', ' Ảnh kính chắn gió trước.'),
//                        SizedBox(height: 15.0,),
//                        TextBulleted("Mỗi xe chụp ít nhất 06 ảnh: 04 ảnh xe , 01 ảnh Đăng kiểm/Số khung & 01 ảnh Kính chắn gió ; Với những xe có giá trị cao như: BMW, Audi, Mercedes... phải chụp thêm các góc độ khác: Nóc, các larăng và có thể kiểm tra nổ máy xe."),
//                        TextBulleted("Trường hợp phát hiện có hư hỏng cần lập biên bản xác nhận tình trạng xe trước khi nhận bảo hiểm."),
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
