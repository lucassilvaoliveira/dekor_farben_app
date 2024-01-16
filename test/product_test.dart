import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/core/entities/user.dart';
import 'package:dekor_farben_app/core/usecases/product/create_product_use_case.dart';
import 'package:dekor_farben_app/global/constants.dart';
import 'package:dekor_farben_app/helpers/data_json_object.dart';
import 'package:dekor_farben_app/helpers/infra_exception.dart';
import 'package:dekor_farben_app/infrastructure/implementations/memory/product_memory_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("should be create product", () async {
    final User adminUser = User(
      id: uuid.v4(),
      userType: "admin",
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userDocument: "13665879957",
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final CreateProductUseCase createProductUseCase = CreateProductUseCase(repository: ProductMemoryRepositoryImpl(), user: adminUser);

    Object sut;

    final call = await createProductUseCase.call(
        product: Product(
      id: uuid.v4(),
      companyId: uuid.v4(),
      productPrice: 50,
      productDescription: "productDescription",
      productName: "productName",
      productImagePath: null,
      productAmount: 50,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut is DataJsonObject, true);
    expect(sut.status, 201);
  });

  test("should be not create product because user is not admin", () async {
    final User user = User(
      id: uuid.v4(),
      userType: "user",
      userEmail: "silvaluxas5@gmail.com",
      userPassword: uuid.v4(),
      userName: "luxas silva",
      telephoneNumber: "47996876877",
      userBirthday: DateTime.now(),
      userDocument: "13665879957",
      userPoints: 500,
      userAvatarPath: null,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    final CreateProductUseCase createProductUseCase = CreateProductUseCase(repository: ProductMemoryRepositoryImpl(), user: user);

    Object sut;

    final call = await createProductUseCase.call(
        product: Product(
      id: uuid.v4(),
      companyId: uuid.v4(),
      productPrice: 50,
      productDescription: "productDescription",
      productName: "productName",
      productImagePath: null,
      productAmount: 50,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));

    call.when((success) => sut = success, (error) => sut = error);

    expect(sut, isA<InfraException>());
    expect(sut.cause, "only admin users can create product!");
  });
}
