import 'package:mobile/src/domain/entities/customer/ArgumentsParam.dart';

class ArgumentsParamCustomerDetail extends ArgumentsCustomerPreview {
  final String createAt;
  final String career;
  final String note;
  final String email;
  final status;

  ArgumentsParamCustomerDetail(
      int id,
      String fullName,
      String phone,
      String identity,
      String tax_code,
      String brithday,
      String gender,
      String address,
      String type,
      this.email,
      this.createAt,
      this.career,
      this.note,
      this.status)
      : super(id, fullName, phone, identity, tax_code, brithday, gender,
            address, type);
}
