import 'package:edental/providers/baseProvider.dart';

import '../models/dentist.dart';

class RecommendationService extends BaseProvider<Dentist, Object> {
  RecommendationService(
      {apiName = 'recommendations', username = '', password = ''})
      : super(apiName, username, password);
}
