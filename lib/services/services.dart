import 'package:dio/dio.dart';
import 'package:jezt_internship_app/endpoints/endpoints.dart';
import 'package:jezt_internship_app/models/dash_board_response.dart';

class Services {
  static Future<Response> login({required Map<String, dynamic> data}) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => status != null && status < 500,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    return await dio.post(Endpoints.login, data: data);
  }

  static Future<DashBoardResponse> fetchDashboardData(
    String accessToken,
  ) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final response = await dio.get(Endpoints.dashboard);

    if (response.statusCode == 200) {
      return DashBoardResponse.fromJson(response.data);
    } else if (response.statusCode == 401) {
      return DashBoardResponse(detail: response.data['detail']);
    } else {
      throw Exception('Unexpected error: ${response.statusCode}');
    }
  }

  static Future<String?> logout(String accessToken) async {
    final dio = Dio(
      BaseOptions(
        validateStatus: (status) => status != null && status < 500,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken',
        },
      ),
    );

    final response = await dio.post(Endpoints.logout);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return null; // Success
    } else if (response.statusCode == 401 && response.data['detail'] != null) {
      return response.data['detail']; 
    } else {
      return 'Logout failed. Please try again.';
    }
  }
}
