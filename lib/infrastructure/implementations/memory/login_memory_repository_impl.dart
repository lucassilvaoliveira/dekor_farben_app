import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/contracts/i_login_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class LoginMemoryRepositoryImpl implements ILoginRepository {

  @override
  Future<Result<DataJsonObject, InfraException>> call({required String email, required String password}) async {
    try {
      return Success(
        DataJsonObject(
          status: 201,
          body: {
            "user": User(
              id: uuid.v4(),
              userType: "user",
              userEmail: "example@gmail.com",
              userPassword: uuid.v4(),
              userName: "luxa silva",
              telephoneNumber: "47996876844",
              userBirthday: DateTime.now(),
              userCpf: 13665879957,
              userPoints: 700,
              userAvatarPath: null,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            )
          },
        ),
      );
    } catch (e) {
      return Error(InfraException(cause: e.toString()));
    }
  }
}
