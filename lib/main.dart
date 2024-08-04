// Project Imports
import 'package:leafguard/controllers/menu_controller.dart' as custom;
import 'package:leafguard/services/agent/agentFactory.dart';
import 'package:leafguard/services/balance/balanceFactory.dart';
import 'package:leafguard/services/billing/billingFactory.dart';
import 'package:leafguard/services/cancellation/cancellationFactory.dart';
import 'package:leafguard/services/category/categoryFactory.dart';
import 'package:leafguard/services/categorymain/categoryMainFactory.dart';
import 'package:leafguard/services/company/companyFactory.dart';
import 'package:leafguard/services/company_booking/companyBookingFactory.dart';
import 'package:leafguard/services/discount/discountFactory.dart';
import 'package:leafguard/services/currency/currencyFactory.dart';
import 'package:leafguard/services/experience/experienceFactory.dart';
import 'package:leafguard/services/paymentgateway/paymentGatewayFactory.dart';
import 'package:leafguard/services/question/questionFactory.dart';
import 'package:leafguard/services/report/reportFactory.dart';
import 'package:leafguard/services/reviews/reviewFactory.dart';
import 'package:leafguard/services/serviceprovider/providerFactory.dart';
import 'package:leafguard/services/services/serviceFactory.dart';
import 'package:leafguard/services/bookings/bookingFactory.dart';
import 'package:leafguard/services/tax/taxFactory.dart';
import 'package:leafguard/services/transaction/transactionFactory.dart';
import 'package:leafguard/services/customer/customerFactory.dart';
import 'package:leafguard/services/login/login_factory.dart';
import 'package:leafguard/screens/signup_signin.dart/user_account_signin.dart';
import 'package:leafguard/services/subadministrator/subadminFactory.dart';
import 'package:leafguard/services/witness/witnessFactory.dart';
import 'package:leafguard/themes/app_theme.dart';
import 'package:leafguard/widgets/signup_signin/oauth.web.service.dart';

// Service Imports
import 'package:leafguard/services/administrator/adminFactory.dart';

// Flutter Imports
import 'package:flutter/material.dart';

// Package Imports
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  setPathUrlStrategy();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => custom.MenuController()),
        ChangeNotifierProvider.value(value: TaxFactory()),
        ChangeNotifierProvider.value(value: LoginFactory()),
        ChangeNotifierProvider.value(value: ReviewFactory()),
        ChangeNotifierProvider.value(value: QuestionFactory()),
        ChangeNotifierProvider.value(value: PaymentFactory()),
        ChangeNotifierProvider.value(value: BillingFactory()),
        ChangeNotifierProvider.value(value: CurrencyFactory()),
        ChangeNotifierProvider.value(value: DiscountFactory()),
        ChangeNotifierProvider.value(value: OAuthWebService()),
        ChangeNotifierProvider.value(value: CustomerFactory()),
        ChangeNotifierProvider.value(value: BalanceFactory()),
        ChangeNotifierProvider.value(value: ExperienceFactory()),
        ChangeNotifierProvider.value(value: CategoryFactory()),
        ChangeNotifierProvider.value(value: CancellationFactory()),
        ChangeNotifierProvider.value(value: AgentFactory()),
        ChangeNotifierProvider.value(value: AdministratorFactory()),
        ChangeNotifierProvider.value(value: MainCategoryFactory()),
        ChangeNotifierProvider.value(value: SubAdministratorFactory()),
        ChangeNotifierProvider.value(value: BookingFactory()),
        ChangeNotifierProvider.value(value: ServiceFactory()),
        ChangeNotifierProvider.value(value: WitnessFactory()),
        ChangeNotifierProvider.value(value: TransactionFactory()),
        ChangeNotifierProvider.value(value: ServiceProviderFactory()),
        ChangeNotifierProvider.value(value: ReportFactory()),
        ChangeNotifierProvider.value(value: CompanyFactory()),
        ChangeNotifierProvider.value(value: CompanyBookingFactory()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LeafGuard",
      theme: AppTheme.theming(context),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const UserSignScreen(),
      },
    );
  }
}
