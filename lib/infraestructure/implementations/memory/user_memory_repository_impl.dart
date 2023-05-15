import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infraestructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UserMemoryRepositoryImpl implements IBaseRepository<User> {
  @override
  Future<Result<List<User>, InfraException>> get({required String? entityId}) async {
    try {
      if (entityId != null) {
        return Success([
          User(
            id: uuid.v4(),
            userType: null,
            userEmail: "example@gmail.com",
            userPassword: uuid.v4(),
            userName: "luxa silva",
            userBirthday: DateTime.now(),
            userCpf: 13665879957,
            userPoints: 700,
            userAvatarPath: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          )
        ]);
      }
      return Success(
        List.generate(
          5,
          (index) => User(
            id: "${uuid.v4()} index: $index",
            userType: null,
            userEmail: "email$index@gmail.com",
            userPassword: "${uuid.v4()} index: $index",
            userName: "user = $index",
            userBirthday: DateTime.now(),
            userCpf: index,
            userPoints: index,
            userAvatarPath: null,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        ),
      );
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }

  @override
  Future<Result<DataJsonObject, InfraException>> put({required User entity}) async {
    try {
      return Success(
        DataJsonObject(status: 201, body: {
          "message": "User created successfully!",
        }),
      );
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }
}
