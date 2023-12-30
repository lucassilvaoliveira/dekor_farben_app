import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IBaseRepository<T> {
  Future<Result<List<T>, InfraException>> get();

  Future<Result<T, InfraException>> getOne({required String? entityId});

  Future<Result<DataJsonObject, InfraException>> put({required T entity});
}
