import 'package:auto_route/auto_route.dart';
import 'package:flutter_application/presentation/screens/faq/broker.dart';
import 'package:flutter_application/presentation/screens/faq/disclaimer.dart';
import 'package:flutter_application/presentation/screens/faq/group.dart';
import 'package:flutter_application/presentation/screens/faq/home.dart';
import 'package:flutter_application/presentation/screens/faq/main.dart';
import 'package:flutter_application/presentation/screens/faq/pick_stock.dart';
import 'package:flutter_application/presentation/screens/faq/privacy.dart';
import 'package:flutter_application/presentation/screens/faq/telegram.dart';
import 'package:flutter_application/presentation/screens/faq/testing.dart';
import 'package:flutter_application/presentation/screens/home/my_broker.dart';
import 'package:flutter_application/presentation/screens/home/my_stock.dart';
import 'package:flutter_application/presentation/screens/home/pick_stock.dart';
import 'package:flutter_application/presentation/screens/auth/login.dart';
import 'package:flutter_application/presentation/screens/auth/register.dart';
import 'package:flutter_application/presentation/screens/auth/forget.dart';
import 'package:flutter_application/presentation/screens/home/warning.dart';
import 'package:flutter_application/presentation/screens/test/main.dart';
import 'package:flutter_application/presentation/screens/user/connect_setting.dart';
import 'guards.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(path: '/', page: PickStockPage, name: 'HomeRoute', initial: true, guards: [AuthGuard]),
    AutoRoute(path: '/warning', page: WarningPage, name: 'WarningRoute', guards: [AuthGuard]),
    AutoRoute(path: '/mystock', page: MyStockPage, name: 'MyStockRoute', guards: [AuthGuard]),
    AutoRoute(path: '/mybroker', page: MyBrokerPage, name: 'MyBrokerRoute', guards: [AuthGuard]),
    AutoRoute(path: '/login', page: LoginPage, name: 'LoginRoute', initial: true, guards: [AuthGuard]),
    AutoRoute(path: '/register', page: RegisterPage, name: 'RegisterRoute', guards: [AuthGuard]),
    AutoRoute(path: '/forget', page: ForgetPage, name: 'ForgetRoute', guards: [AuthGuard]),
    AutoRoute(path: '/connect', page: ConnectSettingPage, name: 'ConnectSettingRoute', guards: [AuthGuard]),
    AutoRoute(path: '/test', page: TestPage, name: 'TestRoute', guards: [AuthGuard]),
    AutoRoute(
      path: '/faq',
      page: FAQMainPage,
      name: 'FAQRoute',
      guards: [AuthGuard],
      children: [
        AutoRoute(path: '', name: 'HomeFAQRoute', page: FAQHomePage),
        AutoRoute(path: 'pickstock', name: 'PickStockFAQRoute', page: PickStockFAQPage),
        AutoRoute(path: 'broker', name: 'BrokerFAQRoute', page: BrokerFAQPage),
        AutoRoute(path: 'group', name: 'GroupFAQRoute', page: GroupFAQPage),
        AutoRoute(path: 'testing', name: 'TestingFAQRoute', page: TestingFAQPage),
        AutoRoute(path: 'telegram', name: 'TelegramFAQRoute', page: TelegramFAQPage),
        AutoRoute(path: 'disclaimer', name: 'DisclaimerFAQRoute', page: DisclaimerFAQPage),
        AutoRoute(path: 'privacy', name: 'PrivacyFAQRoute', page: PrivacyFAQPage),
      ],
    ),
  ],
)
class $AppRouter {} 
