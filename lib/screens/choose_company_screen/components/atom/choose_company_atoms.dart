import 'package:dekor_farben_app/core/entities/company.dart';
import 'package:rx_notifier/rx_notifier.dart';

final companyListState = RxNotifier<List<Company>>([]);
final exceptionOnCompanyListState = RxNotifier<dynamic>(null);

final loadedCompany = RxNotifier.action();

final populateCompanyList = RxNotifier.action();