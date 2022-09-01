// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;

import '../screens/auth/forget.dart' as _i7;
import '../screens/auth/login.dart' as _i5;
import '../screens/auth/register.dart' as _i6;
import '../screens/faq/broker.dart' as _i13;
import '../screens/faq/disclaimer.dart' as _i17;
import '../screens/faq/group.dart' as _i14;
import '../screens/faq/home.dart' as _i11;
import '../screens/faq/main.dart' as _i10;
import '../screens/faq/pick_stock.dart' as _i12;
import '../screens/faq/privacy.dart' as _i18;
import '../screens/faq/telegram.dart' as _i16;
import '../screens/faq/testing.dart' as _i15;
import '../screens/home/my_broker.dart' as _i4;
import '../screens/home/my_stock.dart' as _i3;
import '../screens/home/pick_stock.dart' as _i1;
import '../screens/home/warning.dart' as _i2;
import '../screens/test/main.dart' as _i9;
import '../screens/user/connect_setting.dart' as _i8;
import 'guards.dart' as _i21;

class AppRouter extends _i19.RootStackRouter {
  AppRouter(
      {_i20.GlobalKey<_i20.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i21.AuthGuard authGuard;

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.PickStockPage());
    },
    WarningRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i2.WarningPage());
    },
    MyStockRoute.name: (routeData) {
      final args = routeData.argsAs<MyStockRouteArgs>(
          orElse: () => const MyStockRouteArgs());
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i3.MyStockPage(key: args.key));
    },
    MyBrokerRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i4.MyBrokerPage());
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i5.LoginPage(key: args.key));
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>(
          orElse: () => const RegisterRouteArgs());
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i6.RegisterPage(key: args.key));
    },
    ForgetRoute.name: (routeData) {
      final args = routeData.argsAs<ForgetRouteArgs>(
          orElse: () => const ForgetRouteArgs());
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i7.ForgetPage(key: args.key));
    },
    ConnectSettingRoute.name: (routeData) {
      final args = routeData.argsAs<ConnectSettingRouteArgs>(
          orElse: () => const ConnectSettingRouteArgs());
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: _i8.ConnectSettingPage(key: args.key));
    },
    TestRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.TestPage());
    },
    FAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.FAQMainPage());
    },
    HomeFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.FAQHomePage());
    },
    PickStockFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.PickStockFAQPage());
    },
    BrokerFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.BrokerFAQPage());
    },
    GroupFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.GroupFAQPage());
    },
    TestingFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.TestingFAQPage());
    },
    TelegramFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.TelegramFAQPage());
    },
    DisclaimerFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.DisclaimerFAQPage());
    },
    PrivacyFAQRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.PrivacyFAQPage());
    }
  };

  @override
  List<_i19.RouteConfig> get routes => [
        _i19.RouteConfig(HomeRoute.name, path: '/', guards: [authGuard]),
        _i19.RouteConfig(WarningRoute.name,
            path: '/warning', guards: [authGuard]),
        _i19.RouteConfig(MyStockRoute.name,
            path: '/mystock', guards: [authGuard]),
        _i19.RouteConfig(MyBrokerRoute.name,
            path: '/mybroker', guards: [authGuard]),
        _i19.RouteConfig(LoginRoute.name, path: '/login', guards: [authGuard]),
        _i19.RouteConfig(RegisterRoute.name,
            path: '/register', guards: [authGuard]),
        _i19.RouteConfig(ForgetRoute.name,
            path: '/forget', guards: [authGuard]),
        _i19.RouteConfig(ConnectSettingRoute.name,
            path: '/connect', guards: [authGuard]),
        _i19.RouteConfig(TestRoute.name, path: '/test', guards: [authGuard]),
        _i19.RouteConfig(FAQRoute.name, path: '/faq', guards: [
          authGuard
        ], children: [
          _i19.RouteConfig(HomeFAQRoute.name, path: '', parent: FAQRoute.name),
          _i19.RouteConfig(PickStockFAQRoute.name,
              path: 'pickstock', parent: FAQRoute.name),
          _i19.RouteConfig(BrokerFAQRoute.name,
              path: 'broker', parent: FAQRoute.name),
          _i19.RouteConfig(GroupFAQRoute.name,
              path: 'group', parent: FAQRoute.name),
          _i19.RouteConfig(TestingFAQRoute.name,
              path: 'testing', parent: FAQRoute.name),
          _i19.RouteConfig(TelegramFAQRoute.name,
              path: 'telegram', parent: FAQRoute.name),
          _i19.RouteConfig(DisclaimerFAQRoute.name,
              path: 'disclaimer', parent: FAQRoute.name),
          _i19.RouteConfig(PrivacyFAQRoute.name,
              path: 'privacy', parent: FAQRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.PickStockPage]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.WarningPage]
class WarningRoute extends _i19.PageRouteInfo<void> {
  const WarningRoute() : super(WarningRoute.name, path: '/warning');

  static const String name = 'WarningRoute';
}

/// generated route for
/// [_i3.MyStockPage]
class MyStockRoute extends _i19.PageRouteInfo<MyStockRouteArgs> {
  MyStockRoute({_i20.Key? key})
      : super(MyStockRoute.name,
            path: '/mystock', args: MyStockRouteArgs(key: key));

  static const String name = 'MyStockRoute';
}

class MyStockRouteArgs {
  const MyStockRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'MyStockRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.MyBrokerPage]
class MyBrokerRoute extends _i19.PageRouteInfo<void> {
  const MyBrokerRoute() : super(MyBrokerRoute.name, path: '/mybroker');

  static const String name = 'MyBrokerRoute';
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i19.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({_i20.Key? key})
      : super(LoginRoute.name, path: '/login', args: LoginRouteArgs(key: key));

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i19.PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({_i20.Key? key})
      : super(RegisterRoute.name,
            path: '/register', args: RegisterRouteArgs(key: key));

  static const String name = 'RegisterRoute';
}

class RegisterRouteArgs {
  const RegisterRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.ForgetPage]
class ForgetRoute extends _i19.PageRouteInfo<ForgetRouteArgs> {
  ForgetRoute({_i20.Key? key})
      : super(ForgetRoute.name,
            path: '/forget', args: ForgetRouteArgs(key: key));

  static const String name = 'ForgetRoute';
}

class ForgetRouteArgs {
  const ForgetRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ForgetRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i8.ConnectSettingPage]
class ConnectSettingRoute extends _i19.PageRouteInfo<ConnectSettingRouteArgs> {
  ConnectSettingRoute({_i20.Key? key})
      : super(ConnectSettingRoute.name,
            path: '/connect', args: ConnectSettingRouteArgs(key: key));

  static const String name = 'ConnectSettingRoute';
}

class ConnectSettingRouteArgs {
  const ConnectSettingRouteArgs({this.key});

  final _i20.Key? key;

  @override
  String toString() {
    return 'ConnectSettingRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.TestPage]
class TestRoute extends _i19.PageRouteInfo<void> {
  const TestRoute() : super(TestRoute.name, path: '/test');

  static const String name = 'TestRoute';
}

/// generated route for
/// [_i10.FAQMainPage]
class FAQRoute extends _i19.PageRouteInfo<void> {
  const FAQRoute({List<_i19.PageRouteInfo>? children})
      : super(FAQRoute.name, path: '/faq', initialChildren: children);

  static const String name = 'FAQRoute';
}

/// generated route for
/// [_i11.FAQHomePage]
class HomeFAQRoute extends _i19.PageRouteInfo<void> {
  const HomeFAQRoute() : super(HomeFAQRoute.name, path: '');

  static const String name = 'HomeFAQRoute';
}

/// generated route for
/// [_i12.PickStockFAQPage]
class PickStockFAQRoute extends _i19.PageRouteInfo<void> {
  const PickStockFAQRoute() : super(PickStockFAQRoute.name, path: 'pickstock');

  static const String name = 'PickStockFAQRoute';
}

/// generated route for
/// [_i13.BrokerFAQPage]
class BrokerFAQRoute extends _i19.PageRouteInfo<void> {
  const BrokerFAQRoute() : super(BrokerFAQRoute.name, path: 'broker');

  static const String name = 'BrokerFAQRoute';
}

/// generated route for
/// [_i14.GroupFAQPage]
class GroupFAQRoute extends _i19.PageRouteInfo<void> {
  const GroupFAQRoute() : super(GroupFAQRoute.name, path: 'group');

  static const String name = 'GroupFAQRoute';
}

/// generated route for
/// [_i15.TestingFAQPage]
class TestingFAQRoute extends _i19.PageRouteInfo<void> {
  const TestingFAQRoute() : super(TestingFAQRoute.name, path: 'testing');

  static const String name = 'TestingFAQRoute';
}

/// generated route for
/// [_i16.TelegramFAQPage]
class TelegramFAQRoute extends _i19.PageRouteInfo<void> {
  const TelegramFAQRoute() : super(TelegramFAQRoute.name, path: 'telegram');

  static const String name = 'TelegramFAQRoute';
}

/// generated route for
/// [_i17.DisclaimerFAQPage]
class DisclaimerFAQRoute extends _i19.PageRouteInfo<void> {
  const DisclaimerFAQRoute()
      : super(DisclaimerFAQRoute.name, path: 'disclaimer');

  static const String name = 'DisclaimerFAQRoute';
}

/// generated route for
/// [_i18.PrivacyFAQPage]
class PrivacyFAQRoute extends _i19.PageRouteInfo<void> {
  const PrivacyFAQRoute() : super(PrivacyFAQRoute.name, path: 'privacy');

  static const String name = 'PrivacyFAQRoute';
}
