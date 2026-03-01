import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/Cash_helper/Cash_Helper.dart';
import 'package:meta/meta.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  OtpCubit() : super(OtpInitial());
  final Dio dio = Dio(BaseOptions(baseUrl: "https://signlingo.org/api/"));

  resend_otp({required int userid}) async {
    try {
      emit(OtpLoading());
      final Response r = await dio.post(
        "https://signlingo.org/api/resend-otp",
        data: {"user_id": userid},
      );
      print(r);
      // final String token = r.data["data"]["token"];
      // await CacheHelper.saveData(key: "token", value: token);

      emit(OtpSuccess(token: "token"));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(OtpFailure(errmsg: e.response?.data.toString() ?? "errors"));
    } on Exception catch (e) {
      print(e.toString());
      emit(OtpFailure(errmsg: e.toString()));
    }
  }

  verify_otp({required int userid, required String otp}) async {
    emit(OtpLoading());
    try {
      final Response r = await dio.post(
        "https://signlingo.org/api/verify-otp",
        data: {"user_id": userid, "otp": otp},
      );

      print(r);
      final String token = r.data["data"]["token"];
      await CacheHelper.saveData(key: "token", value: token);
      emit(OtpSuccess(token: token));
    } on DioException catch (e) {
      print("STATUS: ${e.response?.statusCode}");
      print("RESPONSE DATA: ${e.response?.data}");
      emit(OtpFailure(errmsg: e.response?.data.toString() ?? "errors"));
    } on Exception catch (e) {
      print(e.toString());
      emit(OtpFailure(errmsg: e.toString()));
    }
  }
}
