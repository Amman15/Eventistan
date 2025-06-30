import 'package:eventistan/index.dart';
import 'package:eventistan/screens/main_view.dart';
import 'package:eventistan/screens/pay_success/pay_success_widget.dart';
import 'package:eventistan/screens/purchases_screen/purchases_screen.dart';
import 'package:eventistan/screens/settings/settings_widget.dart';
import 'package:eventistan/screens/transaction/transaction_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  main,
  signup,
  login,
  profile,
  eventPage,
  reviewsPage,
  organizerHome,
  eventUploadForm,
  eventList,
  buyTicket,
  loginType,
  settings,
  transaction,
  paySuccess,
  purchases,
}

const Map<AppRoute, String> routeMap = {
  AppRoute.main: '/',
  AppRoute.signup: 'register',
  AppRoute.login: 'login',
  AppRoute.profile: 'profile',
  AppRoute.eventPage: 'eventPage',
  AppRoute.reviewsPage: 'reviewsPage',
  AppRoute.organizerHome: 'organizerHome',
  AppRoute.eventUploadForm: 'eventUploadForm',
  AppRoute.eventList: 'eventList',
  AppRoute.buyTicket: 'buyTicket',
  AppRoute.loginType: 'loginType',
  AppRoute.settings: 'settings',
  AppRoute.transaction: 'transaction',
  AppRoute.paySuccess: 'paySuccess',
  AppRoute.purchases: 'purchases',
};

final goRouterProvider = StateProvider<GoRouter>(
  (ref) {
    final router = GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        // Main View
        GoRoute(
          path: routeMap[AppRoute.main]!,
          name: AppRoute.main.name,
          builder: (context, state) => const MainView(),
          routes: [
            // Signup View
            GoRoute(
              path: routeMap[AppRoute.signup]!,
              name: AppRoute.signup.name,
              builder: (context, state) {
                final type = state.queryParameters['type'] ?? 'Attendee';
                return SignupWidget(
                  type: type,
                );
              },
            ),

            // Login View
            GoRoute(
              path: routeMap[AppRoute.login]!,
              name: AppRoute.login.name,
              builder: (context, state) {
                final userType = state.queryParameters['userType'];
                return LoginWidget(
                  userType: userType,
                );
              },
            ),

            // Profile S2 View
            GoRoute(
              path: routeMap[AppRoute.profile]!,
              name: AppRoute.profile.name,
              builder: (context, state) {
                return const ProfileS2Widget();
              },
            ),

            // Purchases View
            GoRoute(
              path: routeMap[AppRoute.purchases]!,
              name: AppRoute.purchases.name,
              builder: (context, state) {
                return const PurchasesScreen();
              },
            ),

            // Settings View
            GoRoute(
              path: routeMap[AppRoute.settings]!,
              name: AppRoute.settings.name,
              builder: (context, state) {
                return const SettingsWidget();
              },
            ),

            // Reviews View
            GoRoute(
              path: routeMap[AppRoute.reviewsPage]!,
              name: AppRoute.reviewsPage.name,
              builder: (context, state) {
                return const ReviewsWidget();
              },
            ),

            // Organizer Home View
            GoRoute(
              path: routeMap[AppRoute.organizerHome]!,
              name: AppRoute.organizerHome.name,
              builder: (context, state) {
                return const OrganizerHomeWidget();
              },
            ),

            // Event Upload Form View
            GoRoute(
              path: routeMap[AppRoute.eventUploadForm]!,
              name: AppRoute.eventUploadForm.name,
              builder: (context, state) {
                return const EventUploadFormWidget();
              },
            ),

            // Event List View
            GoRoute(
              path: routeMap[AppRoute.eventList]!,
              name: AppRoute.eventList.name,
              builder: (context, params) {
                return const EventListWidget();
              },
              routes: [
                // Event View
                GoRoute(
                  path: routeMap[AppRoute.eventPage]!,
                  name: AppRoute.eventPage.name,
                  builder: (context, state) {
                    final eventId = state.queryParameters['eventId'];
                    return EventPageWidget(
                      eventId: eventId ?? '',
                    );
                  },
                  routes: [
                    // Buy Ticket View
                    GoRoute(
                      path: routeMap[AppRoute.buyTicket]!,
                      name: AppRoute.buyTicket.name,
                      builder: (context, state) {
                        final eventId = state.queryParameters['eventId'];

                        return BuyTicketWidget(
                          eventId: eventId ?? '',
                        );
                      },
                      routes: [
                        // Transaction View
                        GoRoute(
                          path: routeMap[AppRoute.transaction]!,
                          name: AppRoute.transaction.name,
                          builder: (context, state) {
                            return const TransactionWidget();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            // Pay Success View
            GoRoute(
              path: routeMap[AppRoute.paySuccess]!,
              name: AppRoute.paySuccess.name,
              builder: (context, state) {
                final totalAmount = state.queryParameters['totalAmount'];

                return PaySuccessWidget(
                  totalAmount: totalAmount ?? '',
                );
              },
            ),
          ],
        ),
      ],
    );

    return router;
  },
);
