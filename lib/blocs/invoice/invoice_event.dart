import 'dart:io';

import '../../core/entities/invoice.dart';

abstract class InvoiceEvent { }

class CreateInvoiceEvent extends InvoiceEvent {
  final Invoice invoice;
  final File image;

  CreateInvoiceEvent({required this.invoice, required this.image});
}

class ListInvoiceByCompanyEvent extends InvoiceEvent {
  final String companyId;

  ListInvoiceByCompanyEvent({required this.companyId});
}

class ValidateInvoiceEvent extends InvoiceEvent {
  final String invoiceId;

  ValidateInvoiceEvent({required this.invoiceId});

}