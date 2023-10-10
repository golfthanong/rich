import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/utils/utils.dart';

class ContactAPI {
  /// 翻页
  /// refresh 是否刷新
  static Future<ContactResponseEntity> post_contact() async {
    //var response = await HttpUtil().post(
    var response = await HttpUtil().get(
      '/api/chat',
    );
    return ContactResponseEntity.fromJson(response);
  }

  static Future<ContactResponseEntity> post_contact_room(String tokenRoom) async {
    //var response = await HttpUtil().post(
    var response = await HttpUtil().get(
      '/api/chat/$tokenRoom',
    );
    return ContactResponseEntity.fromJson(response);
  }


}
