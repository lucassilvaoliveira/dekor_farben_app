import 'package:dekor_farben_app/blocs/invoice/invoice_event.dart';
import 'package:dekor_farben_app/blocs/invoice/invoice_state.dart';
import 'package:dekor_farben_app/core/usecases/invoice/create_invoice_use_case.dart';
import 'package:dekor_farben_app/core/usecases/invoice/list_invoice_use_case.dart';
import 'package:dekor_farben_app/core/usecases/invoice/validate_invoice_use_case.dart';
import 'package:dekor_farben_app/infrastructure/implementations/http/invoice_http_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InvoiceBloc extends Bloc<InvoiceEvent, InvoiceState> {

  final createInvoiceUseCase
  = CreateInvoiceUseCase(repository: InvoiceHttpRepositoryImpl());

  final listInvoiceByCompanyUseCase = ListInvoiceByCompanyUseCase(
      repository: InvoiceHttpRepositoryImpl());

  final validateInvoiceUseCase = ValidateInvoiceUseCase(
      repository: InvoiceHttpRepositoryImpl());

  InvoiceBloc() : super(InvoiceInitialState()) {
    on<CreateInvoiceEvent>((event, emit) async {
      emit(InvoiceLoadingState());

      final result
      = await createInvoiceUseCase.call(invoice: event.invoice, aFile: event.image);

      if (result.isSuccess()) {
        emit(InvoiceCreateSuccessState());
      } else {
        emit(InvoiceCreateOnErrorState(message: "Failed to create invoice"));
      }
    });
    on<ListInvoiceByCompanyEvent>((event, emit) async {
      emit(InvoiceLoadingState());

      final result = await listInvoiceByCompanyUseCase.call(event.companyId);

      if (result.isSuccess()) {
        emit(InvoiceListByCompanySuccessState(
            invoices: result.tryGetSuccess()!));
      } else {
        emit(InvoiceErrorState());
      }
    });
    on<ValidateInvoiceEvent>((event, emit) async {
      emit(InvoiceLoadingState());

      final result = await validateInvoiceUseCase.call(invoiceId: event.invoiceId);

      if (result.isSuccess()) {
        emit(InvoiceValidationSuccessState());
      } else {
        emit(InvoiceErrorState());
      }
    });
  }
}
