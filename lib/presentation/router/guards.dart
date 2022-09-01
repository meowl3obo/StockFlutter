import 'package:auto_route/auto_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.gr.dart';

class AuthGuard extends AutoRouteGuard {          
  @override          
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool("isLogin");
    var path = resolver.route.path;
    
    if (path == '/login' || path == '/register' || path == '/forget') {
      if(isLogin == null || isLogin == false){               
        resolver.next(true);
      } else {
        router.push(const HomeRoute());
      }
    } else {
      if(isLogin != null && isLogin == true){               
        resolver.next(true);
      } else {
        router.push(LoginRoute());
      }
    }
  }          
}   