import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/entities/news_message.dart';
import 'package:chatty/common/utils/utils.dart';

class NewsMessageAPI {
  /// 翻页
  /// refresh 是否刷新
  static Future<NewsMessageResponseEntity> get_news_message() async {
    //var response = await HttpUtil().post(
    var response = await HttpUtil().get(
      '/api/news_message',
    );
    return NewsMessageResponseEntity.fromJson(response);
  }

  // เอาไว้แสดงทีละประกาศ ติดไว้ก่อนยังไม่ทำ
  // static Future<NewsMessageResponseEntity> get_news_message_byone(String tokenRoom) async {
  //   //var response = await HttpUtil().post(
  //   var response = await HttpUtil().get(
  //     '/api/chat/$tokenRoom',
  //   );
  //   return NewsMessageResponseEntity.fromJson(response);
  // }


}
