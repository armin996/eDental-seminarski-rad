import 'package:flutter_dotenv/flutter_dotenv.dart';

mixin BaseServiceMixin<T> {
  final _apiName = '${T.runtimeType.toString().toLowerCase()}s';
  Future<List<T>> getAll();
  Future<T> getById(dynamic id);
  Future<List<T>> get(dynamic searchRequest, {String? path = ''});
  Future<T> create(dynamic request, {String? path = ''});
  Future<bool?> delete(dynamic objectId);
  Future<List<T>> getMultipleById(dynamic id, {String path = ''});
}
