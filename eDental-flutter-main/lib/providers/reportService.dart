import 'package:edental/providers/baseProvider.dart';
import '../../models/report.dart';

class ReportService extends BaseProvider<Report, Object> {
  ReportService({apiName = 'report', username = '', password = ''})
      : super(apiName, username, password);
}
