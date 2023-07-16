import 'package:rx_notifier/rx_notifier.dart';

final loginTypeState = RxNotifier<String>("");

final userIsCompany = RxNotifier.action();
final userIsCustomer = RxNotifier.action();

final userIsAuthenticatedState = RxNotifier<bool>(false);

final authenticateUser = RxNotifier.action();