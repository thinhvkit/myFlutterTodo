import 'package:my_todo/src/core/utils/constants.dart';

import 'package:dio/dio.dart';
import 'package:my_todo/src/data/models/task_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'task_api_service.g.dart';

@RestApi(baseUrl: kBaseUrl)
abstract class TaskApiService {
  factory TaskApiService(Dio dio, {String baseUrl}) = _TaskApiService;

  @GET('/tasks')
  Future<HttpResponse<TaskResponseModel>> getTasks();
}
