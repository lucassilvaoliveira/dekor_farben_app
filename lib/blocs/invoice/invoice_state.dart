abstract class InvoiceState { }

class InvoiceInitialState extends InvoiceState { }
class InvoiceLoadingState extends InvoiceState { }

class InvoiceCreateSuccessState extends InvoiceState { }

class InvoiceCreateOnErrorState extends InvoiceState {
  final String message;

  InvoiceCreateOnErrorState({required this.message});
}
