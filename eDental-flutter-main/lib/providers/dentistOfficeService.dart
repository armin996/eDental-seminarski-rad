import 'package:edental/models/dentistOffice.dart';

import 'baseProvider.dart';

class DentistOfficeService extends BaseProvider<DentistOffice, Object> {
  DentistOfficeService(
      {apiName = 'dentistoffice', username = '', password = ''})
      : super(apiName, username, password);
}
