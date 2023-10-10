import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/utils/utils.dart';

class UserAPI {
  static Future<UserLoginResponseEntity> Login({
    LoginRequestEntity? params,
  }) async {

     var response = await HttpUtil().post(

       '/api/auth/login',

        data: params?.toJson()  //ต้นแก้
    );

    print(response);
    return UserLoginResponseEntity.fromJson(response);

  }



  static Future<UserLoginResponseEntity> get_profile() async {
    var response = await HttpUtil().post(
      'api/get_profile',
    );
    return UserLoginResponseEntity.fromJson(response);
  }

  static Future<BaseResponseEntity> UpdateProfile({
    LoginRequestEntity? params,
  }) async {
    var response = await HttpUtil().post(
      'api/update_profile',
      queryParameters: params?.toJson(),
    );
    return BaseResponseEntity.fromJson(response);
  }
}
