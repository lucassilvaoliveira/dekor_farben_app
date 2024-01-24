import 'package:dekor_farben_app/blocs/product/product_event.dart';
import 'package:dekor_farben_app/blocs/product/product_state.dart';
import 'package:dekor_farben_app/core/entities/product.dart';
import 'package:dekor_farben_app/core/usecases/product/create_product_use_case.dart';
import 'package:dekor_farben_app/core/usecases/product/update_product_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/product_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final createProductUseCase = CreateProductUseCase(
      repository: ProductHttpRepositoryImpl()
  );

  final updateProductUseCase = UpdateProductUseCase(
      repository: ProductHttpRepositoryImpl()
  );

  ProductBloc() : super(ProductInitState()) {
    on<CreateProductEvent>((event, emit) async {
      emit(ProductLoadingState());

      final aName = event.request.name;
      final aDescription = event.request.description;
      final aPrice = event.request.price;
      final companyId = event.request.companyId;
      final campaignId = event.request.campaignId;

      final aProduct = Product(
          id: "",
          campaignId: campaignId,
          companyId: companyId,
          productPrice: aPrice,
          productName: aName,
          productDescription: aDescription,
          productImagePath: "",
          productAmount: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await createProductUseCase.call(product: aProduct, file: event.file);

      if (result.isSuccess()) {
        emit(ProductCreateSuccessState());
      } else {
        emit(ProductCreateFailureState());
      }
    });
    on<UpdateProductEvent>((event, emit) async {
      emit(ProductLoadingState());

      final aProduct = Product(
          id: event.request.id,
          companyId: event.request.companyId,
          campaignId: event.request.campaignId,
          productPrice: event.request.price,
          productName: event.request.name,
          productDescription: event.request.description,
          productImagePath: "",
          productAmount: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now()
      );

      final result = await updateProductUseCase.call(id: event.request.id, product: aProduct, file: event.file);

      if (result.isSuccess()) {
        emit(ProductUpdateSuccessState());
      } else {
        emit(ProductUpdateFailureState());
      }
    });
  }

}