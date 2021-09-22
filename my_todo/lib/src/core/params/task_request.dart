import '../utils/constants.dart';

class TaskRequestParams {
  final String apiKey;
  final int page;
  final int pageSize;

  const TaskRequestParams({
    this.apiKey = kApiKey,
    this.page = 1,
    this.pageSize = 20,
  });
}
