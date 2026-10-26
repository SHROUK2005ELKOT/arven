import 'package:arven/core/constants/end_points.dart';
import 'package:arven/features/auth/data/models/login_request_model.dart';
import 'package:arven/features/auth/data/models/refresh_request_model.dart';
import 'package:arven/features/auth/data/models/register_request_model.dart';
import 'package:arven/features/auth/data/models/verify_email_request_model.dart';
import 'package:dio/dio.dart';

class AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSource(this.dio);

  Future<Response> register(RegisterRequestModel model) async {
    return await dio.post(
      '${EndPoints.baseUrl}${EndPoints.register}',
      data: model.toJson(),
      options: Options(
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 20),
      ),
    );
  }
  Future<Response> login(LoginRequestModel model) async {
  return await dio.post(
    '${EndPoints.baseUrl}/auth/login',
    data: model.toJson(),

    
  );
}
Future<Response> verifyEmail(
   VerifyEmailRequestModel model, ) async { 
    return await dio.post( 
      '${EndPoints.baseUrl}${EndPoints.verifyEmail}', 
    data: model.toJson(), ); }

    
Future<Response> resendOtp(String email) async {
  return await dio.post(
    '${EndPoints.baseUrl}${EndPoints.resendOtp}',
    data: {
      'email': email,
    },
    options: Options(
      receiveTimeout: const Duration(seconds: 20),
      sendTimeout: const Duration(seconds: 20),
    ),
  );
  
}

Future<Response> refreshToken(
  RefreshTokenRequestModel model,
) async {
  return await dio.post(
    '${EndPoints.baseUrl}${EndPoints.refreshToken}',
    data: model.toJson(),
  );
}

}