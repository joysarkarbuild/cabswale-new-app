import 'package:dio/dio.dart';
import 'package:cabswalle/modules/splash/data/models/app_data_model.dart';

class AppDataRepository {
  final Dio _dio;

  AppDataRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<AppDataModel> fetchAppVersion() async {
    try {
      final response = await _dio.get(
        'https://us-central1-cabswale-dev.cloudfunctions.net/settings-getSettingsDoc',
        queryParameters: {
          'docId': "app",
        },
      );

      if (response.statusCode == 200) {
        print("app data res ${response.data}");
        return AppDataModel.fromJson(response.data as Map<String, dynamic>);
      } else {
        throw Exception(
            'Failed to fetch app data. Status code: ${response.statusCode}');
      }
    } on DioException catch (dioError) {
      // Handle Dio-specific exceptions
      throw Exception('Error fetching app data: ${dioError.message}');
    } catch (e) {
      // Handle any other errors
      throw Exception('Unexpected error fetching app data: $e');
    }
  }
}
