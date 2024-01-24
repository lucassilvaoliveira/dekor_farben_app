import '../../core/entities/invoice.dart';

abstract class InvoiceState { }

class InvoiceInitialState extends InvoiceState { }
class InvoiceLoadingState extends InvoiceState { }
class InvoiceErrorState extends InvoiceState { }

class InvoiceCreateSuccessState extends InvoiceState { }

class InvoiceCreateOnErrorState extends InvoiceState {
  final String message;

  InvoiceCreateOnErrorState({required this.message});
}

class InvoiceListByCompanySuccessState extends InvoiceState {
  final List<Invoice> invoices;

  InvoiceListByCompanySuccessState({required this.invoices});
}

class InvoiceValidationSuccessState extends InvoiceState { }