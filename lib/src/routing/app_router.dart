import 'package:aguas_da_borborema/src/features/general_navigation/presentation/app_layout.dart';
import 'package:aguas_da_borborema/src/features/general_navigation/presentation/home.dart';
import 'package:aguas_da_borborema/src/routing/contacts_screen.dart';
import 'package:aguas_da_borborema/src/features/map/presentation/map_screen.dart';
import 'package:aguas_da_borborema/src/routing/not_found_screen.dart';
import 'package:aguas_da_borborema/src/routing/not_implemented_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_forecast.dart';

part 'app_router.g.dart';

class UnpackedRouteBase {
  const UnpackedRouteBase({required this.icon, required this.text});

  final Icon icon;
  final String text;
}

final appRouteNameToIcon = {
  AppRoute.home.name:
      const UnpackedRouteBase(icon: Icon(Icons.house), text: "Home"),
  AppRoute.chat.name:
      const UnpackedRouteBase(icon: Icon(Icons.chat), text: "Chat"),
  AppRoute.map.name:
      const UnpackedRouteBase(icon: Icon(Icons.map_outlined), text: "Mapa"),
  AppRoute.forecast.name: const UnpackedRouteBase(
      icon: Icon(Icons.cloudy_snowing), text: "Previsões"),
  AppRoute.settings.name: const UnpackedRouteBase(
      icon: Icon(Icons.settings), text: "Configurações"),
  AppRoute.contacts.name:
      const UnpackedRouteBase(icon: Icon(Icons.people), text: "Contatos"),
};

enum AppRoute { home, chat, map, forecast, settings, contacts }

@Riverpod(keepAlive: true)
GoRouter goRouter(Ref ref) {
  // final authRepository = ref.watch(authRepositoryProvider);
  final routes = [
    GoRoute(
        path: '/',
        name: AppRoute.home.name,
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'chat/:model_name',
            name: AppRoute.chat.name,
            builder: (context, state) {
              // final modelName = state.pathParameters['model_name']!;
              // return ChatScreen(modelName: modelName);
              return NotImplementedScreen();
            },
            // routes: [
            // GoRoute(
            //   path: 'list_model',
            //   name: AppRoute.leaveReview.name,
            //   pageBuilder: (context, state) {
            //     final productId = state.pathParameters['id']!;
            //     return MaterialPage(
            //       fullscreenDialog: true,
            //       child: LeaveReviewScreen(productId: productId),
            //     );
            //   },
            // ),
            // ],
          ),
          GoRoute(
            path: 'map',
            name: AppRoute.map.name,
            builder: (context, state) {
              return const MapScreen();
            },
          ),
          GoRoute(
            path: 'forecast',
            name: AppRoute.forecast.name,
            builder: (context, state) {
              return const NotImplementedScreen();
            },
          ),
          GoRoute(
            path: 'settings',
            name: AppRoute.settings.name,
            builder: (context, state) {
              return const NotImplementedScreen();
            },
          ),
          GoRoute(
            path: 'contacts',
            name: AppRoute.contacts.name,
            builder: (context, state) {
              return const ContactsScreen();
            },
          ),

          // GoRoute(
          //   path: 'product/:id',
          //   name: AppRoute.product.name,
          //   builder: (context, state) {
          //     final productId = state.pathParameters['id']!;
          //     return ProductScreen(productId: productId);
          //   },
          //   routes: [
          //     GoRoute(
          //       path: 'review',
          //       name: AppRoute.leaveReview.name,
          //       pageBuilder: (context, state) {
          //         final productId = state.pathParameters['id']!;
          //         return MaterialPage(
          //           fullscreenDialog: true,
          //           child: LeaveReviewScreen(productId: productId),
          //         );
          //       },
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'cart',
          //   name: AppRoute.cart.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: ShoppingCartScreen(),
          //   ),
          //   routes: [
          //     GoRoute(
          //       path: 'checkout',
          //       name: AppRoute.checkout.name,
          //       pageBuilder: (context, state) => const MaterialPage(
          //         fullscreenDialog: true,
          //         child: CheckoutScreen(),
          //       ),
          //     ),
          //   ],
          // ),
          // GoRoute(
          //   path: 'orders',
          //   name: AppRoute.orders.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: OrdersListScreen(),
          //   ),
          // ),
          // GoRoute(
          //   path: 'account',
          //   name: AppRoute.account.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: AccountScreen(),
          //   ),
          // ),
          // GoRoute(
          //   path: 'signIn',
          //   name: AppRoute.signIn.name,
          //   pageBuilder: (context, state) => const MaterialPage(
          //     fullscreenDialog: true,
          //     child: EmailPasswordSignInScreen(
          //       formType: EmailPasswordSignInFormType.signIn,
          //     ),
          //   ),
          // ),
        ])
  ];
  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: false,
    redirect: (context, state) {
      if (state.uri.path.startsWith("chat")) {
        // TODO: Check if there is a "selected model" already, if not redirect user to settings
      }
      // final hasSelectedModel = ref.watch()
      // TODO: Implement an authentication logic?
      // final isLoggedIn = authRepository.currentUser != null;
      // final path = state.uri.path;
      // if (isLoggedIn) {
      //   if (path == '/signIn') {
      //     return '/';
      //   }
      // } else {
      //   if (path == '/account' || path == '/orders') {
      //     return '/';
      //   }
      // }
      // return null;
    },
    // refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      ShellRoute(
          builder: (context, state, child) =>
              AppLayout(child: child, routes: routes),
          routes: routes),
    ],
    errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
