import 'dart:convert';

import 'dart:io';

class FileUti {
  static String convertFileToByteArray(String filePath){
    final file = new File(filePath);
    return base64Encode(file.readAsBytesSync());
  }

  static List<String> convertListFileToByteArray(List<String> listFilePath){
    final listData = new List<String>();
    listFilePath.forEach( (String filePath) {
      listData.add(convertFileToByteArray(filePath));
    });
    return listData;
  }
}