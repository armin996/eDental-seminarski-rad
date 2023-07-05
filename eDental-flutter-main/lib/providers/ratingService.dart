import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:edental/apimodels/ratingSearchRequest.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../models/rating.dart';
import 'baseProvider.dart';

class RatingService extends BaseProvider<Rating, RatingSearchRequest> {
  bool _canRate = false;
  bool get canRate => _canRate;
  RatingService({apiName = 'ratings', username = '', password = ''})
      : super(apiName, username, password);

  Future<double> calculateDentistRating(int? dentistId) async {
    final searchRequest = RatingSearchRequest(null, dentistId);
    final result = await find(searchRequest, path: '/filtering');
    double rating = result.isEmpty
        ? 0
        : result
                .map((e) => e.rate)
                .reduce((value, element) => value + element) /
            result.length;
    return rating;
  }

  Future<bool> checkIfRatingApproved(int userId, int dentistId) async {
    final url = dotenv.env["API_URL"];
    final queryParams = {'dentistId': dentistId};
    final ratingUrl =
        Uri.parse('$url/ratings/canRate?userId=$userId&dentistId=$dentistId');
    final result = await http.get(ratingUrl, headers: super.headers);
    final deserializedResult = JsonMapper.deserialize<bool>(result.body);
    return deserializedResult ?? false;
  }
}
