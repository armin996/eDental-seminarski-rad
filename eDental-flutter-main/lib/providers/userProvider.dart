import 'package:edental/providers/baseProvider.dart';

import '../models/user.dart';

class UserProvider extends BaseProvider<User, Object> {
  UserProvider({apiName = 'users', username = '', password = ''})
      : super(apiName, username, password);
}
