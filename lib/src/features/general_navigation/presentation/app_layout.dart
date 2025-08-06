import 'package:pluvia/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

extension GoRouteWithIcon on GoRoute {
  Icon get icon {
    return appRouteNameToIcon[name]!.icon;
  }

  String get text {
    return appRouteNameToIcon[name]!.text;
  }
}

List<GoRoute> unpackRoutes(List<RouteBase> routes) {
  return unpackRoutesRecursive(routes, "");
}

List<GoRoute> unpackRoutesRecursive(List<RouteBase> routes, String pathPrefix) {
  List<GoRoute> unpackedRoutes = [];
  for(var route in routes) {
    route = (route as GoRoute);

    var path = route.path;
    if (pathPrefix == "/") {
      path = "/${route.path}";
    } else if (pathPrefix != "") {
      path = "$pathPrefix/${route.path}";
    }
    
    final newRoute = GoRoute(path: path, name: route.name, builder: route.builder);
    unpackedRoutes.add(newRoute);
    if (route.routes != []) {
      var innerRoutes = unpackRoutesRecursive(route.routes, path);
      unpackedRoutes.addAll(innerRoutes);
    }
  }
  return unpackedRoutes;
}

// An AppLayout is a wrapper widget that creates a drawer for its wrapped widget (child)
class AppLayout extends ConsumerWidget {
  const AppLayout({super.key, required this.child, required this.routes});
  final Widget child;
  final List<RouteBase> routes;
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final isDrawerOpen = ref.watch(drawerStateProvider);
    
    // List<UnpackedRouteBase> unpackedRoutes = unpackRouteBase(routes);
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('PluvIA'),
      //   backgroundColor: const Color(0xFF0b2351),
      // ),
      body: child,
      // drawer: Drawer(
      //   child: ListView(
      //     children: unpackRoutes(routes).map((innerRoute) {
      //       return ListTile(
      //         leading: innerRoute.icon,
      //         title: Text(innerRoute.text),
      //         onTap: () {
      //           Navigator.of(context).pop();
      //           context.go(innerRoute.path);
      //         }
      //       );
      //     } ).toList(),
      //   )
      // )
    );
  }
}