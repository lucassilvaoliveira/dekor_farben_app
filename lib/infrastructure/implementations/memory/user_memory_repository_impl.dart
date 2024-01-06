import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_base_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UserMemoryRepositoryImpl implements IBaseRepository<User> {
  @override
  Future<Result<List<User>, InfraException>> get() async {
    try {
        return Success(
          List.generate(
            5,
            (index) => User(
              id: "${uuid.v4()} index: $index",
              userType: null,
              userEmail: "email$index@gmail.com",
              userPassword: "${uuid.v4()} index: $index",
              userName: "user = $index",
              telephoneNumber: "47996876844",
              userBirthday: DateTime.now(),
              userDocument: "$index",
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
  Future<Result<User, InfraException>> getOne({required String? entityId}) async {
    if (entityId != null) {
      return Success(User(
        id: entityId,
        userType: null,
        userEmail: "example@gmail.com",
        userPassword: uuid.v4(),
        userName: "luxa silva",
        telephoneNumber: "47996876844",
        userBirthday: DateTime.now(),
        userDocument: "13665879957",
        userPoints: 700,
        userAvatarPath: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ));
    }
    return Error(InfraException(cause: "'entityId is missing'"));
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
