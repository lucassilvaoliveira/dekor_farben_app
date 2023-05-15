import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginRepository {
  Future<Result<DataJsonObject, InfraException>> call({required String email, required String password});
}
