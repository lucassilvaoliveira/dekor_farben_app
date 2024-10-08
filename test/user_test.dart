import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/core/usecases/user/create_user_use_case.dart';
import 'package:dekor_farben_app/core/usecases/user/get_one_user_use_case.dart';
import 'package:dekor_farben_app/core/usecases/user/get_user_use_case.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/implementations/memory/user_memory_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be create a new user", () async {
    final createUserUseCase = CreateUserUseCase(repository: UserMemoryRepositoryImpl());
    Object sut;

    final newUser = User(
      id: uuid.v4(),
      userType: null,
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "Lucas",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userDocument: "13665879957",
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final call = await createUserUseCase.call(user: newUser);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is DataJsonObject, true);
    expect(sut.status, 201);
  });

  test("should be return error when try create null user", () async {
    final createUserUseCase = CreateUserUseCase(repository: UserMemoryRepositoryImpl());
    Object sut;

    final call = await createUserUseCase.call(user: null);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut, isA<InfraException>());
  });

  test("should be return a list of users", () async {
    final GetUserUseCase getUserUseCase = GetUserUseCase(repository: UserMemoryRepositoryImpl());
    Object sut;

    final call = await getUserUseCase.call();

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is List<User>, true);
  });

  test("should be return an specific user", () async {
    final GetOneUserUseCase getOneUserUseCase = GetOneUserUseCase(repository: UserMemoryRepositoryImpl());
    Object sut;

    final User userToFind = User(
      id: uuid.v4(),
      userType: null,
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876844",
      userBirthday: DateTime.now(),
      userDocument: "13665879957",
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final call = await getOneUserUseCase.call(userId: userToFind.id);

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut.id, userToFind.id);
  });
}
