import 'package:dekor_farben_app/core/usecases/authentication/login_use_case.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/implementations/memory/login_memory_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be authenticate an user", () async {
    final loginUseCase = LoginUseCase(repository: LoginMemoryRepositoryImpl());
    Object sut;

    final call = await loginUseCase.call(email: "silvaluxas5@gmail.com", password: "123456");

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is DataJsonObject, true);
    expect(sut.status, 201);
  });

  test("should be not authenticate an user", () async {
    final loginUseCase = LoginUseCase(repository: LoginMemoryRepositoryImpl());
    Object sut;

    final call = await loginUseCase.call(email: null, password: "213");

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut, isA<InfraException>());
  });
}
