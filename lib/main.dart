import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:onicame/Dashboard/screens/Ranks/ranks.dart';
import 'package:onicame/Dashboard/screens/dashboard/dashboard_screen.dart';
import 'package:onicame/Dashboard/screens/mastercard/mymaster_card.dart';
import 'package:onicame/Dashboard/screens/support/support.dart';
import 'package:onicame/Dashboard/screens/vendor/vendor_screen.dart';

import 'package:onicame/admin/about/about.dart';
import 'package:onicame/admin/active_buyer.dart';
import 'package:onicame/admin/adminwidthdraw.dart';
import 'package:onicame/admin/banner.dart';
import 'package:onicame/admin/carts.dart';
import 'package:onicame/admin/our_balance.dart';
import 'package:onicame/admin/privacy.dart';
import 'package:onicame/admin/product.dart';
import 'package:onicame/admin/withdraw_users.dart';

import 'package:onicame/utils/colors.dart';
import 'package:onicame/utils/images.dart';

import 'package:url_strategy/url_strategy.dart';
import 'Dashboard/screens/Earning/eraning_screen.dart';
import 'Dashboard/screens/genology/genology.dart';
import 'Dashboard/screens/support/components/edit.dart';
import 'Dashboard/screens/withdraw/withdrawscreen.dart';
import 'Dashboard/screens/withdrawhistry.dart';
import 'admin/admin_screen.dart';
import 'admin/term_and_condition.dart';
import 'screen/Pages/About/about_page.dart';
import 'screen/Pages/Home/home_page.dart';
import 'screen/Pages/Register/registraion_page.dart';
import 'screen/Pages/product/productpage.dart';
import 'screen/signin_screen.dart';

final box = GetStorage();
AppImages appImages = AppImages();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Firebase.initializeApp();

  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: <GoRoute>[
        GoRoute(
            name: 'admin',
            path: '/admin',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const AdminScreen());
            }),
        GoRoute(
            name: 'home',
            path: '/',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: HomePage());
            }),
        GoRoute(
            name: 'about-us',
            path: '/about-us',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: AboutPage());
            }),
        GoRoute(
            name: 'registration',
            path: '/registration',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const RegistrationPage());
            },
            routes: [
              GoRoute(
                name: 'ref',
                path: 'reflink/:id',
                pageBuilder: (context, state) {
                  return NoTransitionPage<void>(
                    key: state.pageKey,
                    child: RegistrationPage(
                      data: state.params['id']!.toString(),
                    ),
                  );
                },
              ),
            ]),
        GoRoute(
          name: 'products',
          path: '/products',
          pageBuilder: (context, state) {
            return NoTransitionPage<void>(
                key: state.pageKey, child: const ProductPage());
          },
        ),
        GoRoute(
            name: 'dashboard',
            path: '/dashboard',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const Dashboard());
            }),
        GoRoute(
            name: 'login',
            path: '/login',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const LoginScreen());
            }),
        GoRoute(
            name: 'cartlist',
            path: '/cartlist',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const CardLists());
            }),

        //adminpanel routes
        GoRoute(
            name: 'banner',
            path: '/banner',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const BannerSection());
            }),
        GoRoute(
            name: 'our-balance',
            path: '/our-balance',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const OurBalance());
            }),
        GoRoute(
            name: 'vendor',
            path: '/vendor',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const VendorScreen());
            }),
        GoRoute(
            name: 'my-master-card',
            path: '/my-master-card',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const MyMasterCard());
            }),
        GoRoute(
            name: 'withdrawn-approve',
            path: '/withdrawn-approve',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const WithDrawnApply());
            }),
        GoRoute(
            name: 'add-new-product',
            path: '/add-new-product',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const ProductScreen());
            }),
        GoRoute(
            name: 'active-buyer',
            path: '/active-buyer',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const ActiveBuyers());
            }),
        GoRoute(
            name: 'create-about',
            path: '/create-about',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const About());
            }),
        GoRoute(
            name: 'create-privacy',
            path: '/create-privacy',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const Privacy());
            }),
        GoRoute(
            name: 'term-conditions',
            path: '/term-conditions',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const TermandCon());
            }),
        GoRoute(
            name: 'genology',
            path: '/genology',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const GenologyScreen());
            }),

        GoRoute(
            name: 'earning',
            path: '/earning',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const EarningScreen());
            }),
        GoRoute(
            name: 'withdraw',
            path: '/withdraw',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const WithDrawScreen());
            }),
        GoRoute(
            name: 'withdraw-history',
            path: '/withdraw-history',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const WithDrawHistry());
            }),
        GoRoute(
            name: 'account',
            path: '/account',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const supportScreen());
            }),
        GoRoute(
            name: 'edit-account',
            path: '/edit-account',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const EditsupportScreen());
            }),
        GoRoute(
            name: 'ranks',
            path: '/ranks',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const RankScreen());
            }),
        GoRoute(
            name: 'admin_withdraw',
            path: '/admin_withdraw',
            pageBuilder: (context, state) {
              return NoTransitionPage<void>(
                  key: state.pageKey, child: const AdminWithDrawHistry());
            }),
      ],
      errorPageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text(
                "Not Found",
                style: TextStyle(color: kPrimaryClr, fontSize: 20),
              ),
            ),
          )));
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Onicame',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: kBlackClr,
            ),
          )),
      builder: EasyLoading.init(),
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
