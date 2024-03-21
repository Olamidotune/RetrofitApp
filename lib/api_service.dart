import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:retrofit_app/screens/home_screen.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://randomuser.me/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("api/?results=3")
  Future<UserDetails> getUserDetails();
}
